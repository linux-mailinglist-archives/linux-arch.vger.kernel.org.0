Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B10241FECA
	for <lists+linux-arch@lfdr.de>; Sun,  3 Oct 2021 01:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhJBXpw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 19:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbhJBXps (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 19:45:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6D7C0613EF;
        Sat,  2 Oct 2021 16:44:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HMNpy1d9Pz4xb9;
        Sun,  3 Oct 2021 10:43:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1633218235;
        bh=jdy5JNJViBbQceeojrb8Lg+GiJVod62XNefz9Q9zGMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rLO4CxydwThjUYpKtT+ewMDVdVfKgCUwXrMukvMI1VENAoBzrFq71t4MN+6vbfVl2
         fpPtMPnefXCa8oYRNOzlImwID10tgnIpA9sveg8qEGU4QACpUb2AjUUDGx3ESg00Xs
         zkUnh3hPftLvlEMti64+zjYQzCjeU6w/1fdveZCbQeJ6c2YqUItmyBjGVEVzyw8jv8
         XK1pHUwz03abFsQ0b7r6dtl+8LbQzouyMfQW+zJCgzhTxj3AwcULYWKDNVuX0v8NXg
         vBVj4+Rqgcu7D2yuTjoAwK9Htz79Vq6AZd5MBrdIdzef9FkZptW2qIDrCxEQxeFXFW
         nmt2SFbhCMPKQ==
Date:   Sun, 3 Oct 2021 10:43:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Joe Perches <joe@perches.com>, Jonas Bonn <jonas@southpole.se>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Sean Christopherson <seanjc@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH RESEND 2 00/16] Resend bitmap patches
Message-ID: <20211003104353.7787c3e9@canb.auug.org.au>
In-Reply-To: <YVjm3NXEhoBQtUSI@yury-ThinkPad>
References: <20211001181245.228419-1-yury.norov@gmail.com>
        <20211003094722.434c030d@canb.auug.org.au>
        <YVjm3NXEhoBQtUSI@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+sbm5rWV9n_aJg+5hEB3VwJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/+sbm5rWV9n_aJg+5hEB3VwJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Sat, 2 Oct 2021 16:10:20 -0700 Yury Norov <yury.norov@gmail.com> wrote:
>
> Ok, I'll resend it based on Linus tree shortly

There is no big hurry, the next linux-next release will not be until
Tuesday (my time).  So you have time to retest after the rebase.

--=20
Cheers,
Stephen Rothwell

--Sig_/+sbm5rWV9n_aJg+5hEB3VwJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFY7rkACgkQAVBC80lX
0GxF9gf+KAnaxw0eisqqSqcepbYMcwRtN4jFLkus8fDpuO17V4jnFQLsw22GkxaP
Mcrbu2fgU/PVCWgxn/3uRSlJnjb0jaZ44zVym1DBof8qIiX5YIiDjaTobS7r16L+
Bbiaury6Fe2RTDRqsxgiMtSJ4+DzQXNyRqNocCsMSElLwDjs3YARuFBS+dh/enDA
uqX2MA+FH2Ijb75pqd/ui1ydpehNWtgvCKFltoaVTKEV2NP7ex2617WmSifleQOy
xnWdwCU3UH8FA05x0q6B1o9TgpqHSjDeuq5A8AlM/s2Efh9rAU3lh4JTkKC69XLo
+B2Tj8og5FXwIiw40Ua9fIxIZ0uJ5w==
=4tcx
-----END PGP SIGNATURE-----

--Sig_/+sbm5rWV9n_aJg+5hEB3VwJ--
