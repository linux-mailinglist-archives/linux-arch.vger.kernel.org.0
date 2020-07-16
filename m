Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32F7222F61
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 01:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgGPXtZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 19:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgGPXtZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jul 2020 19:49:25 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71DFC204EC;
        Thu, 16 Jul 2020 23:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943364;
        bh=uaPx3NHnlak2s8/Bw+uGgnUTIdfrCFx1I8qftHQtHq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fgauLvK2grUIhQBTb8Kt72Cvi9foLQMtrzTNppPRjRLgEqf5/zk4D8Hd4ov/rUrea
         SJKe2ZtuyRZuq0sAAz10PvHkNRjbm0BeGGA2GXk1/Gl0G9JkOK5n3PHZ4Je2jlrvHs
         sft8edVKvC9SHbZQbOORP7He9vfhSNpTqREj5yfM=
Date:   Thu, 16 Jul 2020 16:49:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: clean up address limit helpers v2
Message-Id: <20200716164924.15e373f4dbb3071e9d4ee37c@linux-foundation.org>
In-Reply-To: <20200714105505.935079-1-hch@lst.de>
References: <20200714105505.935079-1-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 14 Jul 2020 12:54:59 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> in preparation for eventually phasing out direct use of set_fs(), this
> series removes the segment_eq() arch helper that is only used to
> implement or duplicate the uaccess_kernel() API, and then adds
> descriptive helpers to force the kernel address limit.
> 
> 
> Changes since v1:
>  - drop to incorrect hunks
>  - fix a commit log typo

I think this *is* v1.  I can't find any differences in the patches and I
was unable to eyeball any changelog alterations?

