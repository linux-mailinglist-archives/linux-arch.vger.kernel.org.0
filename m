Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7882F30E778
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 00:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhBCXhz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 18:37:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233393AbhBCXhq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 18:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612395380;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=9K+vlsSgvaEXlEYmvQtufCl8VYLVay5BoB8zrikelTY=;
        b=gYNEiK3tvjaOgW6fwjjuMui3Scd/OtM6YuTmQTZwjCx3Hi+ByKMM0TV7XIL0mZS/bhLHI9
        0zli2KkDJwwuuTMbUmDZKo18i/ETZZKTkTsSIM39VUoRLn1YfsEV1QZjgbm8/SsPqh9V1n
        T4ry0nHE816Z28zI+Z6nZFENwpNXC/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-s_UUVXGKORilm-3j6tKLsQ-1; Wed, 03 Feb 2021 18:36:16 -0500
X-MC-Unique: s_UUVXGKORilm-3j6tKLsQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 813D6183CD00;
        Wed,  3 Feb 2021 23:36:13 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-197.ams2.redhat.com [10.36.112.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 094025D9E8;
        Wed,  3 Feb 2021 23:36:12 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 113Na9ke4105253
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 4 Feb 2021 00:36:09 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 113Na7h84105252;
        Thu, 4 Feb 2021 00:36:07 +0100
Date:   Thu, 4 Feb 2021 00:36:07 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v7 2/2] Kbuild: implement support for DWARF v5
Message-ID: <20210203233607.GI4020736@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-3-ndesaulniers@google.com>
 <CAK7LNAQW3XtBGAg6u+86wGc0tizDyezZ_f61JjkT15QH5BtGjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQW3XtBGAg6u+86wGc0tizDyezZ_f61JjkT15QH5BtGjA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 04, 2021 at 08:06:12AM +0900, Masahiro Yamada wrote:
> GCC never outputs '.file 0', which is why
> this test is only needed for Clang, correct?

No, GCC outputs .file 0 if it during configure time detected assembler that
supports it and doesn't have any of the known bugs related to it.
But that means kernel doesn't need to care because GCC already took care of
that.

	Jakub

