Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DD83AA179
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFPQjR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 12:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhFPQjR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 12:39:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5325DC061574;
        Wed, 16 Jun 2021 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=amXA5DbpjsK6z6OozTNT4JwawEseuiTE2IRGyEgfxc0=; b=EKjRJP/D6AtT/jvfxesq/zn+X0
        vdbEnOW9ybPOfoUgQaR6zJxTCL8EOJkYLJV1sB40Juy5qU6yLPh3wginXJUR7eYprXEffSSc31C8j
        8JAunLJz18MTOR+D9Fy+z+m/S/BNxWdAhyxlkHVREbKfMV7pbG3jCkovKM+Um46sySoUmDEkhvN4Z
        hikVR5mTZNwHlNZwxflAHGLtQiwWG6FzPqAsZHi0vSpS8T8wDaLPOtXDd2sOfy2c6jG3q6JW8SbWi
        w4+RiTxmktkrIjSyNdYYnFLc/4KFmH9cUXcyHX/dH6lygLf3H64BkQ9mrZ2KpOFBaXepkvfjGxC5M
        mDm/cEyA==;
Received: from c-73-223-233-156.hsd1.ca.comcast.net ([73.223.233.156] helo=[10.193.95.42])
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltYX7-008MFA-6K; Wed, 16 Jun 2021 16:37:00 +0000
Subject: Re: [PATCH 11/18] ps3disk: use memcpy_{from,to}_bvec
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20210615132456.753241-1-hch@lst.de>
 <20210615132456.753241-12-hch@lst.de>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <e15447e1-753a-ba0b-d016-8b8ab2302fd1@infradead.org>
Date:   Wed, 16 Jun 2021 09:36:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615132456.753241-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph,

On 6/15/21 6:24 AM, Christoph Hellwig wrote:
> Use the bvec helpers instead of open coding the copy.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/ps3disk.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)

I tested your patch set applied to v5.13-rc6 on PS3 and it seemed to be
working OK.

I did some rsync's, some dd's, some fsck's, etc.  If you have anything
you could suggest that you think would exercise your changes I could
try that also.

Tested-by: Geoff Levand <geoff@infradead.org>
