Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA896CEC9A
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjC2PQy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 11:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjC2PQx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 11:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F3526A5
        for <linux-arch@vger.kernel.org>; Wed, 29 Mar 2023 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680102962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yn7L6Gf5Ys1fnh23z7AVkJPW9NwbK9fjx3dyKcciMAc=;
        b=i/haw84WZ+O0X7Y9UBPtjixYcdzJT2ADIEXqDlpIE7YgTvxFYsRWKpy2kY9z+FLH9cRtfr
        0hvszl13Wy4OujT9Qu3G5EchaBUp16VBKCJThMMJ0rSUivWm5No41TCm4BSZhMWKfJnJjk
        odlP/R3cB9RO4mJBEOoFWNlPDBWtI9Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-EXRMXSF_PnSmrGoNDhg8iw-1; Wed, 29 Mar 2023 11:15:54 -0400
X-MC-Unique: EXRMXSF_PnSmrGoNDhg8iw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB7092814247;
        Wed, 29 Mar 2023 15:15:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8A94D492C3E;
        Wed, 29 Mar 2023 15:15:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 29 Mar 2023 17:15:21 +0200 (CEST)
Date:   Wed, 29 Mar 2023 17:15:16 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org, catalin.marinas@arm.com, arnd@arndb.de,
        will@kernel.org, mark.rutland@arm.com, tongtiangen@huawei.com,
        robin.murphy@arm.com, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v14 1/4] asm-generic,arm64: create task variant of
 access_ok
Message-ID: <20230329151515.GA913@redhat.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328164811.2451-2-gregory.price@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hmm. I am not comfortable with this change...

I won't really argue because I don't have a better solution and because
I think we don't really care as long as task_set_syscall_user_dispatch()
is the only user of task_access_ok(), but still...

OK, so this version changes set_syscall_user_dispatch() to use
task_access_ok() instead of access_ok() because task != current.

On 03/28, Gregory Price wrote:
>
> If the architecture does not implement task_access_ok, the operation
> reduces to access_ok and the task argument is discarded.

No, with this patch it reduces to __access_ok(). And this already doesn't
look very good to me, but this is minor.

> --- a/include/asm-generic/access_ok.h
> +++ b/include/asm-generic/access_ok.h
> @@ -45,4 +45,14 @@ static inline int __access_ok(const void __user *ptr, unsigned long size)
>  #define access_ok(addr, size) likely(__access_ok(addr, size))
>  #endif
>
> +/*
> + * Some architectures may have special features (such as ARM MTE)
> + * that require handling if access_ok is called on a pointer from one
> + * task in the context of another.  On most architectures this operation
> + * is equivalent to simply __access_ok.
> + */
> +#ifndef task_access_ok
> +#define task_access_ok(task, addr, size) likely(__access_ok(addr, size))
> +#endif

Lets ignore arm64.

This look as if access_ok() or __access_ok() doesn't depend on task, but
this is not true in general. Say, TASK_SIZE_MAX can check is_32bit_task()
test_thread_flag(TIF_32BIT...) and this uses "current".

Again, we probably do not care, but I don't like the fact task_access_ok()
looks as if task_access_ok(task) returns the same result as "task" calling
access_ok().

Oleg.

