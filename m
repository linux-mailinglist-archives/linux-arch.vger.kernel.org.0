Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48F2308E47
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhA2UTC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:19:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233054AbhA2UTB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 15:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611951454;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=3W/U2GBNiUXOVq9NMd7nVXM4YErVjermutIrsOy/S4s=;
        b=U7AxOeJoYr0/iQksvNG5wJm090zhy7RIJC5jXLr9ZDnOL69DkNc4wtFUVYiOyRm0tqDzK/
        5Cjo3qCineaWSYw5sucXLCqcFi6MdM81RTJWw9HfjaUckEaeqGWHwoLCgU4mp+Cz0oPhEf
        wdp+wcl+WAI2K2IREamvM8Rnc5oI0/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-9fMf1rNKMvaCwOvRcrJ4vQ-1; Fri, 29 Jan 2021 15:17:32 -0500
X-MC-Unique: 9fMf1rNKMvaCwOvRcrJ4vQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 970748144E0;
        Fri, 29 Jan 2021 20:17:29 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-64.ams2.redhat.com [10.36.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA4F25C257;
        Fri, 29 Jan 2021 20:17:25 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 10TKHH9i2368212
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 21:17:17 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 10TKHCBD2368211;
        Fri, 29 Jan 2021 21:17:12 +0100
Date:   Fri, 29 Jan 2021 21:17:12 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v6 1/2] Kbuild: make DWARF version a choice
Message-ID: <20210129201712.GQ4020736@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129194318.2125748-2-ndesaulniers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 11:43:17AM -0800, Nick Desaulniers wrote:
> Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
> explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
> way that's forward compatible with existing configs, and makes adding
> future versions more straightforward.
> 
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-by: Fangrui Song <maskray@google.com>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  Makefile          |  6 +++---
>  lib/Kconfig.debug | 21 ++++++++++++++++-----
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 95ab9856f357..20141cd9319e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -830,9 +830,9 @@ ifneq ($(LLVM_IAS),1)
>  KBUILD_AFLAGS	+= -Wa,-gdwarf-2
>  endif
>  
> -ifdef CONFIG_DEBUG_INFO_DWARF4
> -DEBUG_CFLAGS	+= -gdwarf-4
> -endif
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> +DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)

Why do you make DWARF2 the default?  That seems a big step back from what
the Makefile used to do before, where it defaulted to whatever DWARF version
the compiler defaulted to?
E.g. GCC 4.8 up to 10 defaults to -gdwarf-4 and GCC 11 will default to
-gdwarf-5.
DWARF2 is more than 27 years old standard, DWARF3 15 years old,
DWARF4 over 10 years old and DWARF5 almost 4 years old...
It is true that some tools aren't DWARF5 ready at this point, but with GCC
defaulting to that it will change quickly, but at least DWARF4 support has
been around for years.

	Jakub

