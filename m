Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50CF308F18
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhA2VMm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 16:12:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233092AbhA2VMl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 16:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611954675;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=shT0OeZAFzbhZjSLEQmMeSn6z+pT7stkEH8f+xcX918=;
        b=TMoakqykxbPhoaASeZHbOhc0j5W9CCw7soGjg1xVkO3VuDe6G84fhw4lhIY40JMTyWzdiE
        DGk1cxhxi73vOcL+X3+DLzepdpCZ5IMl0lhDHXA53eCbqEkpa49QNF6UOEQxdv/ZHGv381
        IQ4gsh3E2hHhmZx0WXpV/I6TsYBFufQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-Vw16BpxQMgqiuTPKuage9A-1; Fri, 29 Jan 2021 16:11:11 -0500
X-MC-Unique: Vw16BpxQMgqiuTPKuage9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCB9B802B46;
        Fri, 29 Jan 2021 21:11:08 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-64.ams2.redhat.com [10.36.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F05C5C257;
        Fri, 29 Jan 2021 21:11:08 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 10TLB4Bq2565520
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 22:11:05 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 10TLB3RH2565499;
        Fri, 29 Jan 2021 22:11:03 +0100
Date:   Fri, 29 Jan 2021 22:11:02 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nick Clifton <nickc@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
Message-ID: <20210129211102.GT4020736@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com>
 <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
 <20210129205702.GS4020736@tucnak>
 <CAKwvOdmuSaf28dOdP8Yo6+RyiviMNKcq8JY=-qgbwjbPVwHmLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmuSaf28dOdP8Yo6+RyiviMNKcq8JY=-qgbwjbPVwHmLw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 01:05:56PM -0800, Nick Desaulniers wrote:
> > Wasn't that fixed in GAS?
> > https://sourceware.org/bugzilla/show_bug.cgi?id=27195
> 
> $ make LLVM=1 -j72 defconfig
> $ ./scripts/config -e DEBUG_INFO -e DEBUG_INFO_DWARF5
> $ make LLVM=1 -j72
> ...
> /tmp/init-d50d89.s: Assembler messages:
> /tmp/init-d50d89.s:10: Error: file number less than one
> /tmp/init-d50d89.s:11: Error: junk at end of line, first unrecognized
> character is `m'
> 
> which is https://sourceware.org/bugzilla/show_bug.cgi?id=25611.
> 
> $ as --version | head -n1
> GNU assembler (GNU Binutils for Debian) 2.35.1
> 
> Maybe GAS should not need to be told -gdwarf-5 to parse these?  Then
> we would not need to pass -Wa,-gdwarf-5 via clang with
> -no-integrated-as.

That is what sw#27195 is about, just try current binutils 2.35, 2.36 or
trunk branches.

	Jakub

