Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C383B865F
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jun 2021 17:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhF3PlY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Jun 2021 11:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235508AbhF3PlX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Jun 2021 11:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625067534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+7qb56Fa10ok2Oadr2/+uCK0Dvlj0DBDn1L4UGecR1c=;
        b=hsswLukYjt1HG7SDY0w/5BgcfMdw7KsHcRKqROY6AUadVc6UaldLDviBFpxKzHRIUMOnBv
        S2QE7xHcSlSfZKZMNmot0x0229I2DyzmbMiNNPYBZkepOZA2ZU0sbo3JhjvQDdru2Zh2PY
        qjnbz7Q6G9I8ICOdsOa1LU1Ce4WYX9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-f0i0izyvMdmuVR6VOUfIgg-1; Wed, 30 Jun 2021 11:38:52 -0400
X-MC-Unique: f0i0izyvMdmuVR6VOUfIgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06B2918414B4;
        Wed, 30 Jun 2021 15:38:51 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EAAF1F6;
        Wed, 30 Jun 2021 15:38:48 +0000 (UTC)
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
Date:   Wed, 30 Jun 2021 17:38:47 +0200
In-Reply-To: <030f1462-2bf9-39bc-d620-6d9fbe454a27@metux.net> (Enrico
        Weigelt's message of "Wed, 30 Jun 2021 17:16:06 +0200")
Message-ID: <87lf6ricqg.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Enrico Weigelt:

> On 30.06.21 16:34, Florian Weimer wrote:
>
>> It breaks integration with system-wide settings, such as user/group
>> databases, host name lookup, and cryptographic policies.  In many
>> environments, that is not really an option.
>
> Not necessarily, these can still be applied (and fairly simple).
> You actually have to twist more extra knobs if to wanted those weird
> things to happen.

Sorry, this is just not true.  You cannot load system libraries such as
NSS modules or cryptographic libraries with a custom glibc because the
system glibc could be newer, and glibc does not provide that kind of
compatibility (only the other way round).

Thanks,
Florian

