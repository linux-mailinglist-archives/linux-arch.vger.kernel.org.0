Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEFD3BD746
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhGFNA2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 09:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231501AbhGFNA1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 09:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625576269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ytlF4FE3cl9dxZ8jYCvSYMBBS99A2hZUnRZlAgau2m8=;
        b=QhWutB7IX6AgE6w7Be5RO29SQJh4SSSpHwWN+0XXZskTx3ivz7jccpYw1VfGe7KAEC3uGF
        +IK1LRufyubiz4CZIctmdcGDQKG5fNb+D7YPQFZgHP2DfiNtRBuN+DNp/tllNvRX5xHTjd
        FL1PDNytgO/G+t1foLrXJBPfw+mr+mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-HM_70VIjNNaXbS_t2qk2NQ-1; Tue, 06 Jul 2021 08:57:47 -0400
X-MC-Unique: HM_70VIjNNaXbS_t2qk2NQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 349A8100CA88;
        Tue,  6 Jul 2021 12:57:46 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 127825D6A1;
        Tue,  6 Jul 2021 12:57:43 +0000 (UTC)
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
        <878s2qh2bb.fsf@oldenburg.str.redhat.com>
        <034dcf9b-1f8c-23ee-86a6-791122bc0f8c@metux.net>
Date:   Tue, 06 Jul 2021 14:57:42 +0200
In-Reply-To: <034dcf9b-1f8c-23ee-86a6-791122bc0f8c@metux.net> (Enrico
        Weigelt's message of "Thu, 1 Jul 2021 13:59:33 +0200")
Message-ID: <87eecbfvll.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Enrico Weigelt:

> On 01.07.21 10:21, Florian Weimer wrote:
>> * Enrico Weigelt:
>> 
>>> And I'm repeating my previous questions: can you name some actual real
>>> world (not hypothetical or academical) scenarios where:
>>>
>>> somebody really needs some binary-only application &&
>>> needs those extra modules *into that* application &&
>>> cannot recompile these modules into the applications's prefix &&
>>> needs AMX in that application &&
>>> cannot just use chroot &&
>>> cannot put it into container ?
>> There are no real-world scenarios yet which involve AMX, so I'm not
>> sure
>> what you are after with this question.
>
> Okay, let's take AMX out of the equation (until it actually arrives
> in the field). How does it look like then ?

We have customers that want to use name service switch (NSS) plugins in
proprietary software and who do not want to distribute the (GNU)
toolchain with their application.  The latter excludes
chroot/containers.  Some applications more or less require to run
directly on the host (e.g., if they have some system monitoring aspect).

Thanks,
Florian

