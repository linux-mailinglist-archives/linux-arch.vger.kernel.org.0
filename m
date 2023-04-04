Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0726D5DD8
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjDDKqR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 06:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjDDKqP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 06:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674991BD9
        for <linux-arch@vger.kernel.org>; Tue,  4 Apr 2023 03:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680605125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KlvAHwxh15I5CJgOz3iBO5tT4tChRwyHMt1NQ+o3LIA=;
        b=HN3gaZbYaTrCSODkOxumWlTDQEdhdl6hxXcJznxvgV3/b1zBJ8TPxOtBEd69IXc8+vM7CS
        IYjOk/PC6VOboCekfBjIuY3lKSL0xfpzzvbuA2Gq4vzBCwtL1fj7uHazuzZpGsYhaGcg0r
        nqCDDYgHGaVEbdyagpn4EyZHWIQEF7E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-KKW9AEdFMjO660zewoQhLg-1; Tue, 04 Apr 2023 06:45:19 -0400
X-MC-Unique: KKW9AEdFMjO660zewoQhLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3BBB80D190;
        Tue,  4 Apr 2023 10:45:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.199])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7493B40C6EC4;
        Tue,  4 Apr 2023 10:45:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  4 Apr 2023 12:45:10 +0200 (CEST)
Date:   Tue, 4 Apr 2023 12:45:06 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, arnd@arndb.de,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v15 2/4] syscall user dispatch: untag selector addresses
 before access_ok
Message-ID: <20230404104506.GA24740@redhat.com>
References: <20230330212121.1688-1-gregory.price@memverge.com>
 <20230330212121.1688-3-gregory.price@memverge.com>
 <ZCYP+4gRZDqC0lRo@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCYP+4gRZDqC0lRo@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Catalin,

doesn't this mean that access_ok() on arm64 could use
untagged_addr(addr) unconditionally without any security risk?

On 03/30, Catalin Marinas wrote:
>
> On Thu, Mar 30, 2023 at 05:21:22PM -0400, Gregory Price wrote:
> > diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
> > index 22396b234854..16086226b41c 100644
> > --- a/kernel/entry/syscall_user_dispatch.c
> > +++ b/kernel/entry/syscall_user_dispatch.c
> > @@ -87,7 +87,18 @@ static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned lon
> >  		if (offset && offset + len <= offset)
> >  			return -EINVAL;
> >
> > -		if (selector && !access_ok(selector, sizeof(*selector)))
> > +		/*
> > +		 * access_ok will clear memory tags for tagged addresses on tasks where
> > +		 * memory tagging is enabled.  To enable a tracer to set a tracee's
> > +		 * selector not in the same tagging state, the selector address must be
> > +		 * untagged for access_ok, otherwise an untagged tracer will always fail
> > +		 * to set a tagged tracee's selector.
> > +		 *
> > +		 * The result of this is that a tagged tracer may be capable of setting
> > +		 * an invalid address, and the tracee will SIGSEGV on the next syscall.
> > +		 * This is equivalent to a task setting a bad selector (selector=0x1).
> > +		 */
>
> I'd drop the last paragraph above. Even without tagged pointers, a tracer
> can set an invalid address (as you already mentioned) but the phrasing
> some implies (to me) that if we did it differently, the tracer would not be
> able to set an invalid pointer.
> 
> Either way,
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> -- 
> Catalin
> 

