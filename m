Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD7A421E96
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 08:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhJEGEW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 02:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhJEGET (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 02:04:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3838C061745;
        Mon,  4 Oct 2021 23:02:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HNn6Z0Lw4z4xbT;
        Tue,  5 Oct 2021 17:02:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1633413746;
        bh=NxMykwAtSBGQYw1NN1b8tuLk3z/eu8KgxmvlevpwR08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AuN21dHC9+MvuIwLhRD96bDPhCznYUF4mW6sVZScbRUzl9khYXUvaDeVKY7j3EpSi
         SxLzKS1Bs4wrte7aWbXpZFWoemH0PNGO4D37mni3TZjB1HF9v41Jp65nKUZ8k7EWb7
         1WS06ttvm7jDrexi/wdAcBbdmsaNmdqfqkCfLltRleNNHw6/4tsoys9pHDR4kMpQ3X
         hiZ975kZUM946XlJkVfu3fcj8ixvWtI9+4vCQ14o+3BoPZXOQo2KwupnUaz3BSOQLv
         PP+voIhGccH2rnqTb4t4QCc3N3EFgiuOYx9ydItftfDiXwetSYPCE98mkJ03f/99MZ
         0OvLwF5mq8Z4Q==
Date:   Tue, 5 Oct 2021 17:02:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
Subject: Re: [PATCH RESEND 3 00/16] Bitmap patches for 5.15
Message-ID: <20211005170213.6e4ca629@canb.auug.org.au>
In-Reply-To: <20211005054059.475634-1-yury.norov@gmail.com>
References: <20211005054059.475634-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UQDD3e=d/fr65N4eQ6HWDaN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/UQDD3e=d/fr65N4eQ6HWDaN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Mon,  4 Oct 2021 22:40:43 -0700 Yury Norov <yury.norov@gmail.com> wrote:
>
> Please pull this bitmap series. The git tree is here:
>         https://github.com/norov/linux/tree/bitmap-master-5.15

Actually branch bitmap-master-5.15 of https://github.com/norov/linux.git

I would prefer a more generic branch name (unless this is a short term
tree - since I will fetch it every day until you tell me to stop)

Added to linux-next from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/UQDD3e=d/fr65N4eQ6HWDaN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFb6mUACgkQAVBC80lX
0Gxbewf/Ww/E+XPHdQ1mp59XC0GkoUKOxCBfGR1vs7uFtk/jjJjQgZczaO5K0V8B
5AV4HEuVQrACgBuuHnKuciVhbzgu5zwK6AitIcZTU904LwEr+mUZuhKteKdGMzlp
fIWXLaQEDg3eHhTk3IYFiCJK/xQqU4TxVD4vCCGveKRh2C603nww/En/sYfFrmOk
1ofCL8wN1uxqI+rsm21e2cXvb4IlMto5uimejQmP55fyX9zsdZ95ZUHg3jLb4sy3
JAP298Vgeqhv3ynmkjYzYilP4TC0psiyQMGvwuzlFMN/qaywyQ1OeKYCm0ymgAXr
lnHzfD2RdD0mlcaxkqWAWThdw6GFag==
=qIlm
-----END PGP SIGNATURE-----

--Sig_/UQDD3e=d/fr65N4eQ6HWDaN--
