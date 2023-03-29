Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5266CF0CF
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 19:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjC2ROb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 13:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjC2ROa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 13:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B20212E
        for <linux-arch@vger.kernel.org>; Wed, 29 Mar 2023 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680110021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2HKY/Ux5TNZKEBOMV/tb21I2tofWYzDVBz54QvkxgBg=;
        b=DF4noglDQHrkIauYXsZ+6f9OM2D2H2hHofwlOJxb0BIppmppJeiMpeDUn5XZ2XK0sGFIRR
        XGdy/mlQbwK43wGLfnU2gqEluJCVrIev6CSMzUMk4wexq9MHuJYVdQ8/xK+i4MUD6vjEhs
        uSP7PC9vQB1sLp0f3rAZmAWtmEOGhyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-wDlX7MaCPTeV1v8QlV9ksg-1; Wed, 29 Mar 2023 13:13:36 -0400
X-MC-Unique: wDlX7MaCPTeV1v8QlV9ksg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B37485A588;
        Wed, 29 Mar 2023 17:13:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id 32E7F4020C82;
        Wed, 29 Mar 2023 17:13:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 29 Mar 2023 19:13:27 +0200 (CEST)
Date:   Wed, 29 Mar 2023 19:13:22 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, avagin@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, krisman@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, shuah <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, tongtiangen@huawei.com,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v14 1/4] asm-generic,arm64: create task variant of
 access_ok
Message-ID: <20230329171322.GB4477@redhat.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <20230329151515.GA913@redhat.com>
 <9a456346-e207-44e1-873e-40d21334e01b@app.fastmail.com>
 <20230329160322.GA4477@redhat.com>
 <ZCO20bzX/IB8J6Gp@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCO20bzX/IB8J6Gp@memverge.com>
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

On 03/28, Gregory Price wrote:
>
> Not sure how I should proceed here,

Can't we just kill this access_ok() in set_syscall_user_dispatch() ?
I don't think it buys too much.

Oleg.

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379adff6b..d2e516ece52b 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -43,11 +43,7 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 		return false;
 
 	if (likely(sd->selector)) {
-		/*
-		 * access_ok() is performed once, at prctl time, when
-		 * the selector is loaded by userspace.
-		 */
-		if (unlikely(__get_user(state, sd->selector))) {
+		if (unlikely(get_user(state, sd->selector))) {
 			force_exit_sig(SIGSEGV);
 			return true;
 		}
@@ -86,9 +82,6 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 		if (offset && offset + len <= offset)
 			return -EINVAL;
 
-		if (selector && !access_ok(selector, sizeof(*selector)))
-			return -EFAULT;
-
 		break;
 	default:
 		return -EINVAL;

