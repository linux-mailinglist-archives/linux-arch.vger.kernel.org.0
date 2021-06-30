Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C293B851E
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jun 2021 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhF3OhB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Jun 2021 10:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235303AbhF3Og6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Jun 2021 10:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625063669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ewOhMeXaKjGmJuL1HIfpGhg67sEafkLOgNvC3+bkQqw=;
        b=JLXuyhmIuKaFw0qZpZ7lXEd08QBtI3tVIXLEEN87yZqA20EPoviL+m8XNnwqWHCqsfwOiT
        374o8H54JXVydqJ0uZ41Mp5LwM0Y5oLvoQtDswYPFMpogFs+qwZ6mZikSjv8f2DmuuXAWJ
        P9hqiKDZ1iIWBa/TJ7zJOxNeluA9ZQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-_JHLdgbGNKWarLNYKuA-Aw-1; Wed, 30 Jun 2021 10:34:25 -0400
X-MC-Unique: _JHLdgbGNKWarLNYKuA-Aw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3090B802929;
        Wed, 30 Jun 2021 14:34:24 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FF5C100164A;
        Wed, 30 Jun 2021 14:34:22 +0000 (UTC)
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
Date:   Wed, 30 Jun 2021 16:34:20 +0200
In-Reply-To: <e07294c9-b02a-e1c5-3620-7fae7269fdf1@metux.net> (Enrico
        Weigelt's message of "Wed, 30 Jun 2021 16:32:29 +0200")
Message-ID: <87pmw3ifpv.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Enrico Weigelt:

> OTOH, if one really needs to be independent of distros, one should build
> a complete nano-distro, where everything's installed under certain
> prefix, including libc. Isn't a big deal at all - we have plenty tools
> for that, daily practise in embedded world. The only difference would be
> tweaking the ld scripts to set a different ld.so path.

It breaks integration with system-wide settings, such as user/group
databases, host name lookup, and cryptographic policies.  In many
environments, that is not really an option.

Thanks,
Florian

