Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6127C308EE9
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhA2U6o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233343AbhA2U6l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 15:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611953835;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=jJAl8faLaTXKp5DstykPQouYkGkdmrA8uwwSrWLNEdw=;
        b=YVNQpP1Iw/6Opz/4f6R0KS1JlwojnVGrb2C5fUgiYUT5MhjWdid8aUVzRzimyT6OKil1xp
        aGAXJ1q8hT+6R1h/vMAa653Fk9YJOaCqx7r0wUOW9ZOJZoC9Ta4XrJCwe1yJy1CA8uVmIH
        1ZfZAJpbZGr/Tu+irIL1MNBJoqC+pxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-4jqVEabdM_mz1KST0Orp4A-1; Fri, 29 Jan 2021 15:57:11 -0500
X-MC-Unique: 4jqVEabdM_mz1KST0Orp4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 047F1107ACE3;
        Fri, 29 Jan 2021 20:57:09 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-64.ams2.redhat.com [10.36.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BA7960BE2;
        Fri, 29 Jan 2021 20:57:08 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 10TKv4KA2368399
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 21:57:05 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 10TKv2Kg2368396;
        Fri, 29 Jan 2021 21:57:02 +0100
Date:   Fri, 29 Jan 2021 21:57:02 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
Message-ID: <20210129205702.GS4020736@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com>
 <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 12:48:11PM -0800, Nick Desaulniers wrote:
> > Should this be...?
> >
> > KBUILD_AFLAGS += -Wa,-gdwarf-5
> 
> No; under the set of conditions Clang is compiling .c to .S with DWARF
> v5 assembler directives. GAS will choke unless told -gdwarf-5 via
> -Wa,-gdwarf-5 for .c source files, hence it is a C flag, not an A

Wasn't that fixed in GAS?
https://sourceware.org/bugzilla/show_bug.cgi?id=27195

	Jakub

