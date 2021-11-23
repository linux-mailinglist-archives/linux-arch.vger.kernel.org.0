Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2645ACD9
	for <lists+linux-arch@lfdr.de>; Tue, 23 Nov 2021 20:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbhKWTxw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Nov 2021 14:53:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240077AbhKWTxr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Nov 2021 14:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637697038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4KI1H93I3xG9XwZuvC9rCCKf5tSl7Lx4nyuD6OnlcLQ=;
        b=SC0Nl56suZd0tKwZ0eNEvk8VsI6u2dmuaZL+JdIDqnz6ygZAYCZTRNUbyeDqvDzvOIwGAj
        G0drN9wAU+GOFOfinM9iZVec99hr4a69hlC1nacOWCxUBsdDt40MmQ6CvociHx55hEKxUo
        T4dnZ8QVaj7UOMWNoIrIsmxHWJzFO1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-g8GUzCcIP7q9i3fnOHSj_A-1; Tue, 23 Nov 2021 14:50:37 -0500
X-MC-Unique: g8GUzCcIP7q9i3fnOHSj_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D29818125C1;
        Tue, 23 Nov 2021 19:50:35 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DEBB60CC3;
        Tue, 23 Nov 2021 19:50:33 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
References: <YZvIlz7J6vOEY+Xu@yuki>
        <CAK8P3a0x5Bw7=0ng-s+KsUywqJYa0tk9cSWmZhx+cZRBOR87ZA@mail.gmail.com>
        <YZyw56flmdQnBIuh@yuki>
Date:   Tue, 23 Nov 2021 20:50:31 +0100
In-Reply-To: <YZyw56flmdQnBIuh@yuki> (Cyril Hrubis's message of "Tue, 23 Nov
        2021 10:14:15 +0100")
Message-ID: <87a6hups6w.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Cyril Hrubis:

> As far as I can tell the userspace bits/types.h does exactly the same
> check in order to define uint64_t and int64_t, i.e.:
>
> #if __WORDSIZE == 64
> typedef signed long int __int64_t;
> typedef unsigned long int __uint64_t;
> #else
> __extension__ typedef signed long long int __int64_t;
> __extension__ typedef unsigned long long int __uint64_t;
> #endif
>
> The macro __WORDSIZE is defined per architecture, and it looks like the
> defintions in glibc sources in bits/wordsize.h match the uapi
> asm/bitsperlong.h. But I may have missed something, the code in glibc is
> not exactly easy to read.

__WORDSIZE isn't exactly a standard libc macro.

On musl, x86-64 x32 has __WORDSIZE == 64 depending on header-inclusion
order, but that's probably just a bug.

Thanks,
Florian

