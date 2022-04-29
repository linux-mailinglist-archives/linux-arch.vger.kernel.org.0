Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368295147BD
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 13:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiD2LJh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 07:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbiD2LJh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 07:09:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658122BB3E;
        Fri, 29 Apr 2022 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fMdiNIX6IDBT9DuqskkT0WgA7a07Qd6BHjsFV1ujKlo=; b=e0dW1trDuU4PBeSW86P1pgQAS2
        2nuk5t5yASP8KqGzPRbvt0cBRTGQ7fIQFj2mSk4QyXZ8ZyYIkeBv0PaxcrWTXMqk6H+SYFKBX8Gjk
        i+k8F9N2XDatZdkQgtWGtd3COYPMeU97bH5edEhyCRWPoXhpo9S3dHdil45qQ+azZc7Agi4z5fPHe
        JsoKfPCkxdraIkwe2QDF871CPa2nonymoBcR9emMbsuqiu35DXqp3jo3xxmRLii2o7ufNJvPG7E07
        dsmSSsJdMNycNv+RQjG68xGFBqVLnisrF36wBic9JiA7JRONwm5w75MrdFr2Misi7tg2J8tGKO0qs
        m6HNZXYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkORa-00CLBP-JT; Fri, 29 Apr 2022 11:05:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A312300385;
        Fri, 29 Apr 2022 13:05:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E49320295B05; Fri, 29 Apr 2022 13:05:49 +0200 (CEST)
Date:   Fri, 29 Apr 2022 13:05:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, jthierry@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, masahiroy@kernel.org,
        jpoimboe@redhat.com, ycote@redhat.com, herbert@gondor.apana.org.au,
        mark.rutland@arm.com, davem@davemloft.net, ardb@kernel.org,
        maz@kernel.org, tglx@linutronix.de, luc.vanoostenryck@gmail.com
Subject: Re: [RFC PATCH v4 22/37] arm64: kernel: Skip validation of kuser32.o
Message-ID: <YmvGja62yWdPHPOW@hirez.programming.kicks-ass.net>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
 <20220429094355.122389-23-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429094355.122389-23-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 05:43:40PM +0800, Chen Zhongjin wrote:
> From: Raphael Gault <raphael.gault@arm.com>
> 
> kuser32 being used for compatibility, it contains a32 instructions
> which are not recognised by objtool when trying to analyse arm64
> object files. Thus, we add an exception to skip validation on this
> particular file.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  arch/arm64/kernel/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 986837d7ec82..c4f01bfe79b4 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -41,6 +41,9 @@ obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
>  					   sys_compat.o
>  obj-$(CONFIG_COMPAT)			+= sigreturn32.o
>  obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
> +
> +OBJECT_FILES_NON_STANDARD_kuser32.o := y

File based skipping is depricated in the face of LTO and other link
target based objtool runs.

Please use function based blacklisting as per the previous patch.
