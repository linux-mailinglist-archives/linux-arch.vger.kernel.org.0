Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B7145A936
	for <lists+linux-arch@lfdr.de>; Tue, 23 Nov 2021 17:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhKWQus (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Nov 2021 11:50:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234423AbhKWQus (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Nov 2021 11:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637686059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eGWhtGhPtpq/ZiEd6igWpm4/71FIAUKG5LmWLh1yu0w=;
        b=JykRPLFwPuByq+/c2M3JDK7BWJoWBhGxhkdAz9p3UobOCf9mi0STz+xeHLEQfQfUjCNBaX
        JZPG8RZOxo+FKRSu0HqZuYH9am5aA0u7le+1hyvn+N0WO6JkMzhjVL/KvQ7PTaojACaFAj
        Bj+2ata8re0kmvfYFELQm6E+XenvXYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-66xCcqg-MdGoCOG_LgKrhA-1; Tue, 23 Nov 2021 11:47:36 -0500
X-MC-Unique: 66xCcqg-MdGoCOG_LgKrhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500BA80668B;
        Tue, 23 Nov 2021 16:47:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B473360C7F;
        Tue, 23 Nov 2021 16:47:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YZvIlz7J6vOEY+Xu@yuki>
References: <YZvIlz7J6vOEY+Xu@yuki>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, ltp@lists.linux.it,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1618288.1637686052.1@warthog.procyon.org.uk>
Date:   Tue, 23 Nov 2021 16:47:32 +0000
Message-ID: <1618289.1637686052@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cyril Hrubis <chrubis@suse.cz> wrote:

> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace.

Can you guarantee this won't break anything in userspace?  Granted the types
*ought* to be the same size, but anyone who's written code on the basis that
these are "(unsigned) long long int" may suddenly get a bunch of warnings
where they didn't before from the C compiler.  Anyone using C++, say, may find
their code no longer compiles because overloaded function matching no longer
finds a correct match.

Also, whilst your point about PRIu64 and PRId64 modifiers in printf() is a
good one, it doesn't help someone whose compiler doesn't support that (I don't
know if anyone's likely to encounter such these days).  At the moment, I think
a user can assume that %llu will work correctly both on 32-bit and 64-bit on
all arches, but you're definitely breaking that assumption.

David

