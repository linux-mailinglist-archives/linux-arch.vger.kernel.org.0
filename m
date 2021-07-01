Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F5A3B8EC5
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jul 2021 10:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhGAIYG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jul 2021 04:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235214AbhGAIYG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jul 2021 04:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625127695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLKJhbgcvFuPJHaea6EMauv0v6hOekQR7bhLFOeZe5U=;
        b=ZIGneg0QMtNot/yOFUqx3IE/xGri2A7WkgxNo4Nimot3cud0Azy/PCLPRzhtsXLNem7ieG
        2DkZg5/q8w7NzRmb09Y38UkaFeejeioXnMGtpwlq5U+gHhNObcXeJdwB697QScgDE1DPpQ
        K+KB/pTeDv6Dkk3XHj8vdTbFzAelZiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-0ePXuSitOUWZhHbHAYDBYg-1; Thu, 01 Jul 2021 04:21:34 -0400
X-MC-Unique: 0ePXuSitOUWZhHbHAYDBYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C885D1922965;
        Thu,  1 Jul 2021 08:21:32 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B708060C13;
        Thu,  1 Jul 2021 08:21:30 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Thiago Macieira <thiago.macieira@intel.com>, hjl.tools@gmail.com,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org
Subject: Re: x86 CPU features detection for applications (and AMX)
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
        <3c5c29e2-1b52-3576-eda2-018fb1e58ff9@metux.net>
        <2379132.fg5cGID6mU@tjmaciei-mobl1>
        <e07294c9-b02a-e1c5-3620-7fae7269fdf1@metux.net>
        <87pmw3ifpv.fsf@oldenburg.str.redhat.com>
        <030f1462-2bf9-39bc-d620-6d9fbe454a27@metux.net>
        <87lf6ricqg.fsf@oldenburg.str.redhat.com>
        <4ba30cb7-6854-0691-fad6-4ca9ce674ac2@metux.net>
Date:   Thu, 01 Jul 2021 10:21:28 +0200
In-Reply-To: <4ba30cb7-6854-0691-fad6-4ca9ce674ac2@metux.net> (Enrico
        Weigelt's message of "Thu, 1 Jul 2021 10:08:04 +0200")
Message-ID: <878s2qh2bb.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Enrico Weigelt:

> And I'm repeating my previous questions: can you name some actual real
> world (not hypothetical or academical) scenarios where:
>
> somebody really needs some binary-only application &&
> needs those extra modules *into that* application &&
> cannot recompile these modules into the applications's prefix &&
> needs AMX in that application &&
> cannot just use chroot &&
> cannot put it into container ?

There are no real-world scenarios yet which involve AMX, so I'm not sure
what you are after with this question.

Thanks,
Florian

