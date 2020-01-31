Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC6014EA8D
	for <lists+linux-arch@lfdr.de>; Fri, 31 Jan 2020 11:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgAaKUi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jan 2020 05:20:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39074 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728160AbgAaKUh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jan 2020 05:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580466037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Rvip+9gEMjJ6H84OHoQUknXeHPGXzmy72y0DuVzxqY=;
        b=hdbfVVhbnrTdV/DBYBjxYhjjKXuzhKygdYWxtIUNy3nk4nagKbDH/DARq/r0rJGU6xNcC/
        zUNltzFBdClP0pcXbVnY9/mRju29LmwjXY9MyUiZOb8yteXrg4dymhN9ypx+QiUSimWnoc
        T357e2fcnsjOQH2+55db1i1Nsd5srag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-degvaMcmNIy88Nk77AIFyA-1; Fri, 31 Jan 2020 05:20:28 -0500
X-MC-Unique: degvaMcmNIy88Nk77AIFyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1549107ACC4;
        Fri, 31 Jan 2020 10:20:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-218.rdu2.redhat.com [10.10.120.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E46F5DA75;
        Fri, 31 Jan 2020 10:20:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
References: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com> <20200123153341.19947-1-will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Will Deacon <will@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7435.1580466021.1@warthog.procyon.org.uk>
Date:   Fri, 31 Jan 2020 10:20:21 +0000
Message-ID: <7436.1580466021@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Of course, if you're feeling adventurous and willing to at least entertain the
mere speculation of switching the kernel source to C++, we could then use
inline template functions:

	template <typename T>
	static inline T __READ_ONCE(T &var)
	{
		T val = *(const volatile T *)&var;
		return val;
	}

	template <typename T>
	static inline T READ_ONCE(T &var)
	{
		T val;
		compiletime_assert_rwonce_type(var);
		val = __READ_ONCE(var);
		smp_read_barrier_depends();
		return val;
	}

Of course, that would mean using C++...

David

