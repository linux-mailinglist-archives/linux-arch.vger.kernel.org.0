Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD039FC3E
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFHQWA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 12:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhFHQV7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 12:21:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46D7A6128E;
        Tue,  8 Jun 2021 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623169206;
        bh=qkkyaNSTG8jKDhH3l2/+Ytp2W/YqYbwhA582jK1SRa0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Be8aPjdZ0EtnXdxKyRzx3MB64aOGcU7P5UxQ60lFZJ+Mi3PrAXxve5Kh7ozb6Tst1
         qvq7+rUkGafYRbTp1qyWzVF2n74c0jxpemsTz89k34Sg5GKkitFEgkg/Hy8xQTBO/G
         4Lk64TKYlnvU5TH0F2//tJ9AAIFZwe3CqujZmuLOImNtMXGTiLdshYsjGnuiYZT7Vm
         reo0ICVt6+1ECIYZjX5QbWJ/c1/dTnob5vROygOAmKdZSOrmAwcSFXqsTDg4EbYUTY
         lA/Rbq8XmdekAwv73UgdeNdNqpVAQy91fVbb2tohvlwpmV1x1nhF3fPrwidswlVRB9
         DfX8/CWS7kisg==
Subject: Re: [PATCH v4 2/4] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
 <20210605014216.446867-3-npiggin@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <8ac1d420-b861-f586-bacf-8c3949e9b5c4@kernel.org>
Date:   Tue, 8 Jun 2021 09:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210605014216.446867-3-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/4/21 6:42 PM, Nicholas Piggin wrote:
> Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy tlb mm
> when it is context switched. This can be disabled by architectures that
> don't require this refcounting if they clean up lazy tlb mms when the
> last refcount is dropped. Currently this is always enabled, which is
> what existing code does, so the patch is effectively a no-op.
> 
> Rename rq->prev_mm to rq->prev_lazy_mm, because that's what it is.

I am in favor of this approach, but I would be a lot more comfortable
with the resulting code if task->active_mm were at least better
documented and possibly even guarded by ifdefs.

x86 bare metal currently does not need the core lazy mm refcounting, and
x86 bare metal *also* does not need ->active_mm.  Under the x86 scheme,
if lazy mm refcounting were configured out, ->active_mm could become a
dangling pointer, and this makes me extremely uncomfortable.

So I tend to think that, depending on config, the core code should
either keep ->active_mm [1] alive or get rid of it entirely.

[1] I don't really think it belongs in task_struct at all.  It's not a
property of the task.  It's the *per-cpu* mm that the core code is
keeping alive for lazy purposes.  How about consolidating it with the
copy in rq?

I guess the short summary of my opinion is that I like making this
configurable, but I do not like the state of the code.

--Andy
