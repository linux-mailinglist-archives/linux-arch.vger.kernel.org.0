Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C824130F127
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 11:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhBDKrw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 05:47:52 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:34048 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbhBDKrv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 05:47:51 -0500
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Feb 2021 05:47:51 EST
Received: from librem (ip-213-127-54-204.ip.prioritytelecom.net [213.127.54.204])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 0B649300097B;
        Thu,  4 Feb 2021 11:40:54 +0100 (CET)
Received: by librem (Postfix, from userid 1000)
        id 13BE3C14A7; Thu,  4 Feb 2021 11:39:46 +0100 (CET)
Date:   Thu, 4 Feb 2021 11:39:46 +0100
From:   Mark Wielaard <mark@klomp.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
Message-ID: <20210204103946.GA14802@wildebeest.org>
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130004401.2528717-2-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nick,

On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
> Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
> the default. Does so in a way that's forward compatible with existing
> configs, and makes adding future versions more straightforward.
> 
> GCC since ~4.8 has defaulted to this DWARF version implicitly.

And since GCC 11 it defaults to DWARF version 5.

It would be better to set the default to the DWARF version that the
compiler generates. So if the user doesn't select any version then it
should default to just -g (or -gdwarf).

Thanks,

Mark
