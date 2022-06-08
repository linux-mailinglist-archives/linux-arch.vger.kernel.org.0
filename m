Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE4E542C75
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 12:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiFHKDA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 06:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiFHKCl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 06:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F22B014040D
        for <linux-arch@vger.kernel.org>; Wed,  8 Jun 2022 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654681282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3+IKQAxPaDV1lsEnEpDWXsKDpaqq+QeuuTyOBnuSML8=;
        b=fZyDp39Z40Cps24sKFz9nGbbcGu125DC1tnBoEtml0A26bizwQg2TP89pLQcVePb6kWiQ5
        xTuiA1A0A/X2H7SjB86YVTMXtjbmZ2wcmMZUTD+rQ7nM/xR1j3evNvOTUOO7y+YxGdS4O9
        2dR2Iwjbu2uKVFgySX+fLJReHI9LMLs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-w3WQnUBOPViMCdoJoJfKsA-1; Wed, 08 Jun 2022 05:41:16 -0400
X-MC-Unique: w3WQnUBOPViMCdoJoJfKsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA5C61C01B2C;
        Wed,  8 Jun 2022 09:41:15 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.40.208.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0009D9D7F;
        Wed,  8 Jun 2022 09:41:10 +0000 (UTC)
Date:   Wed, 8 Jun 2022 11:41:08 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     guoren@kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     palmer@dabbelt.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        hch@lst.de, nathan@kernel.org, naresh.kamboju@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        heiko@sntech.de, ldv@strace.io
Subject: Re: [PATCH V12 02/20] uapi: always define
 F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h
Message-ID: <20220608094108.GA18122@asgard.redhat.com>
References: <20220405071314.3225832-1-guoren@kernel.org>
 <20220405071314.3225832-3-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405071314.3225832-3-guoren@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 05, 2022 at 03:12:56PM +0800, guoren@kernel.org wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Note that before this change they were never visible to userspace due
> to the fact that CONFIG_64BIT is only set for kernel builds.

> -#ifndef CONFIG_64BIT
> +#if __BITS_PER_LONG == 32 || defined(__KERNEL__)

Actually, it's quite the opposite: "ifndef" usage made it vailable at all times
to the userspace, and this change has actually broken building strace
with the latest kernel headers[1][2].  There could be some debate
whether having these F_*64 definitions exposed to the user space 64-bit
applications, but it seems that were no harm (as they were exposed already
for quite some time), and they are useful at least for strace for compat
application tracing purposes.

[1] https://github.com/strace/strace/runs/6779763146?check_suite_focus=true#step:4:3222
[2] https://pipelines.actions.githubusercontent.com/serviceHosts/e5309ebd-8a2f-43f4-a212-b52080275b5d/_apis/pipelines/1/runs/1473/signedlogcontent/12?urlExpires=2022-06-08T09%3A37%3A13.9248496Z&urlSigningMethod=HMACV1&urlSignature=fIT7vd0O4NNRwzwKWLXY4UVZBIIF3XiVI9skAsGvV0I%3D

