Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F84308FD8
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhA2WL3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:11:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233451AbhA2WL2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 17:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611958201;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=EmteIPPCRvA0Xzynl4Lpo4s2j4RCjrk806zB4G2tFZU=;
        b=YsF3RV6/+vZCxaMT/skQ9KKaBQtxV8zn+QSpjOVHETgvnMald0aD9JAhNApWEXv+o22zlJ
        C9vKRCZo3i13Oit+KXqu35rrLlJAgtukSmK2UOGjtsqjtJSW59xjERXIS/3+lXOKa6tx1A
        Kv7/DUtp+DE3+1hW2TFQ1hvpAhZyKuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-a8cnRl7KP9u0P2t_e4T3Xw-1; Fri, 29 Jan 2021 17:09:57 -0500
X-MC-Unique: a8cnRl7KP9u0P2t_e4T3Xw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E949802B45;
        Fri, 29 Jan 2021 22:09:55 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-64.ams2.redhat.com [10.36.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD1D71A266;
        Fri, 29 Jan 2021 22:09:54 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 10TM9pe92192088
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 23:09:51 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 10TM9def2179650;
        Fri, 29 Jan 2021 23:09:39 +0100
Date:   Fri, 29 Jan 2021 23:09:39 +0100
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
Message-ID: <20210129220939.GY4020736@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com>
 <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
 <20210129205702.GS4020736@tucnak>
 <CAKwvOdmuSaf28dOdP8Yo6+RyiviMNKcq8JY=-qgbwjbPVwHmLw@mail.gmail.com>
 <20210129211102.GT4020736@tucnak>
 <CAKwvOdm-+xK=diSKKXXnS2m1+W6QZ70c7cRKTbtVF=dWi1_8_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm-+xK=diSKKXXnS2m1+W6QZ70c7cRKTbtVF=dWi1_8_w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 02:05:59PM -0800, Nick Desaulniers wrote:
> Ah, I see.  Then I should update the script I add
> (scripts/test_dwarf5_support.sh) to feature detect that bug, since
> it's the latest of the bunch.  Also, should update my comment to note
> that this requires binutils greater than 2.35.1 (which is what I have,
> which fails, since the backport landed in ... what?!)  How was this
> backported to 2.35
> (https://sourceware.org/bugzilla/show_bug.cgi?id=27195#c12, Jan 26
> 2021) when binutils-2_35_1 was tagged sept 19 2020?  Or will there be
> a binutils 2.35.2 point release?

AFAIK yes, soon.

	Jakub

