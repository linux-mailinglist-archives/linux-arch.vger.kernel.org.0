Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5A5308F8F
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhA2VnR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 16:43:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232727AbhA2VnP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 16:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611956509;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=/8sb/8sHZzMY1LKnIg86HfMzKFR8QSCQ0s3LqHm0oMw=;
        b=MIIllmDCeIgPl0pFRw28guJSmfrtBJVFBcRTzMzJ/m08PWQ7dHXmHV3lNv4eJV3PnVlMd2
        JLY0DzxqFQHrIxN4gmbDSumhATkXeLAHHg+8gPWfUNGdSNbW7h1aSaDyECLibXJ/NXfmje
        zZYYdxv9D3Ph28oQpgbhgIaLqqDECIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-QS_yEcSqOJiHcpfjpran0A-1; Fri, 29 Jan 2021 16:41:45 -0500
X-MC-Unique: QS_yEcSqOJiHcpfjpran0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4B4B804017;
        Fri, 29 Jan 2021 21:41:42 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-64.ams2.redhat.com [10.36.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5114860C5C;
        Fri, 29 Jan 2021 21:41:42 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 10TLfdEk3941781
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 22:41:39 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 10TLfb3Z3938970;
        Fri, 29 Jan 2021 22:41:37 +0100
Date:   Fri, 29 Jan 2021 22:41:37 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v6 1/2] Kbuild: make DWARF version a choice
Message-ID: <20210129214137.GW4020736@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-2-ndesaulniers@google.com>
 <20210129201712.GQ4020736@tucnak>
 <CAKwvOdkqcWOn6G7U6v37kc6gxZ=xbiZ1JtCd4XyCggMe=0v8iQ@mail.gmail.com>
 <CAKwvOdk0zxewEOaFuqK0aSMz3vKNzDOgmez=-Dae4+bodsSg5w@mail.gmail.com>
 <YBR+8KLWnjnMfP6i@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBR+8KLWnjnMfP6i@rani.riverdale.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 04:32:32PM -0500, Arvind Sankar wrote:
> Given what Jakub is saying, i.e. it was previously impossible to get
> dwarf2 with gcc, and you get dwarf4 whether or not DEBUG_INFO_DWARF4 was

It isn't impossible to get it, -gdwarf-2 works, it is just not a very good
choice (at least unless one knows some debug info consumer is not DWARF3 or
later ready).
Though, even gcc -gdwarf-2 will use many extensions from DWARF3 and later,
as long as there is no way to describe stuff in DWARF2.  -gstrict-dwarf
option requests that no DWARF extensions are used.

	Jakub

