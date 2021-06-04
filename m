Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602AB39BDB4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 18:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFDQ4d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 12:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhFDQ4d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 12:56:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D7F4613DE;
        Fri,  4 Jun 2021 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622825687;
        bh=YPazeuzSK6s1SjkSTRVdvHCtW1yCQUOaB+XSbd0sY5I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Gj9oADZdY1B/V7aHBgacFrK6kVejmG0DO3IVgTNWpeipYvvgP33EvEHDl5C6eMa0+
         ObZN3aRVZ5JAHAVf/8al6QZqACzL/WQ245aBA27Q+EUdqx90+Q5/YC0b4Wvs8eijYu
         LGFttuAbi5GmYRRdTeC97vfGt5VErIHSNqddWBNs+/k9gnk9pot8EEEmPykA+cccqO
         vznsvjBHfFADtwjRFvNPhgOMQ5xjtJhRSV63WkzjnG1nY0nbsOKeb7etPKt/JndXRn
         3KMNVtCP9sN4HY3mBwkRXNWvMSGWKbRWi6alDlQnBbEVfwBYzd9o+Tr5AIcBDiiH9o
         ALs3UKpAZ2FhA==
Subject: Re: [PATCH v3 0/4] shoot lazy tlbs
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
References: <20210601062303.3932513-1-npiggin@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <603ffd67-3638-4c47-8067-c1bdfdf65f1b@kernel.org>
Date:   Fri, 4 Jun 2021 09:54:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210601062303.3932513-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/31/21 11:22 PM, Nicholas Piggin wrote:
> There haven't been objections to the series since last posting, this
> is just a rebase and tidies up a few comments minor patch rearranging.
> 

I continue to object to having too many modes.  I like my more generic
improvements better.  Let me try to find some time to email again.
