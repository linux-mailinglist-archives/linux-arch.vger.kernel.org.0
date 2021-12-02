Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDCC466614
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 16:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358166AbhLBPFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 10:05:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358245AbhLBPFW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2021 10:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638457319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/3xlIYEWyvboPKd2VFHttveDDWJjCPblrUV213W3J78=;
        b=FpMoLsxVC4o96Z0B/G8rxZyW0UOs9PAsH6pIoU8eVdXCx0SmrD3rXlQUP4VdD6MbMc7E8H
        5toimUcIB3NHLYUo45C8S4HacR5syfzPQe1YgJT/cNPCGPAMVEatdZ/5ilDXYJL9I2JEkH
        DVseYmg/Oi8sTF/IC08ngJhnivqOs4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-Z6f8F3GTO3ux06V1OWFmmg-1; Thu, 02 Dec 2021 10:01:58 -0500
X-MC-Unique: Z6f8F3GTO3ux06V1OWFmmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D97294EE3;
        Thu,  2 Dec 2021 15:01:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 256E85F4ED;
        Thu,  2 Dec 2021 15:01:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <b8d6f890-e5aa-44bf-8a55-5998efa05967@www.fastmail.com>
References: <b8d6f890-e5aa-44bf-8a55-5998efa05967@www.fastmail.com> <YZvIlz7J6vOEY+Xu@yuki> <1618289.1637686052@warthog.procyon.org.uk> <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com> <YaTAffbvzxGGsVIv@yuki> <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
To:     "Zack Weinberg" <zack@owlfolio.org>
Cc:     dhowells@redhat.com, "Arnd Bergmann" <arnd@arndb.de>,
        "Cyril Hrubis" <chrubis@suse.cz>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        libc-alpha@sourceware.org,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David Laight" <David.Laight@aculab.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <913508.1638457313.1@warthog.procyon.org.uk>
Date:   Thu, 02 Dec 2021 15:01:53 +0000
Message-ID: <913509.1638457313@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Zack Weinberg <zack@owlfolio.org> wrote:

> I could be persuaded otherwise with an example of a program for which
> changing __s64 from 'long long' to 'long' would break *binary* backward
> compatibility, or similarly for __u64.

C++ could break.

David

