Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAD541FE85
	for <lists+linux-arch@lfdr.de>; Sun,  3 Oct 2021 00:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhJBWt3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 18:49:29 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:49893 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhJBWt2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 18:49:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HMMYm0llyz4xR9;
        Sun,  3 Oct 2021 09:47:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1633214860;
        bh=WZxRlkQAJZ4tqNobecHm+w38BSGUESdihRsAdeUkre0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lroR3kmh4LYMftkmOxhvcJS7+pnh3a93hk6rg/CPpoYSU8ZWfL4YBiVSwyH06HYQn
         f6fguCb0AxD7QUqw1YIyq/vJ62G3+TYTtylKrXTUiklrzA/2hOb2fC4LvM/wg4YFSH
         KG8MQhBIPvHuJ1WmyKCn4j6p0KFhw65riWANZ2AVVLuS9pDXeGMd+I50l+GJoQRr6I
         7foBJKgfmCZpsWy6Gj5dPHcRNuO3Ql45XAlDEVOgopLjJY1Os8xgFzWdtrAKgEFmdO
         f4SQ2cUV6Sx1VEbHG7oGcVOzk6jJxI7YA6zFu7LMsSzMNOB/oKsTBZM+GOR73gkWW8
         rv/N36CNA9/kg==
Date:   Sun, 3 Oct 2021 09:47:22 +1100
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
Subject: Re: [PATCH RESEND 2 00/16] Resend bitmap patches
Message-ID: <20211003094722.434c030d@canb.auug.org.au>
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oR.tVRCv.tbi8TditjTwdeB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/oR.tVRCv.tbi8TditjTwdeB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Fri,  1 Oct 2021 11:12:29 -0700 Yury Norov <yury.norov@gmail.com> wrote:
>
> Can you please take this series into the next tree? It has been already
> in next-tree for 5.14:
>=20
> https://lore.kernel.org/linux-mmc/YSeduU41Ef568xhS@alley/T/
>=20
> But it was damaged and we decided to merge it in 5.15 cycle. No changes
> comparing to 5.14, except for Andy's patch that was already upstreamed
> and therefore removed from here.
>=20
> The git tree is here:
> 	https://github.com/norov/linux/tree/bitmap-20210929

Sorry, I cannot include that in linux-next since it it based on (an old
version of) linux-next itself.  If it needs to be based on other trees in
linux-next, then it has to be added to Andrew Morton's patch series (in
the post linux-next section.  Otherwise, if it can be based on Linus
Torvald's tree (even with a few conflicts), then that is better.

--=20
Cheers,
Stephen Rothwell

--Sig_/oR.tVRCv.tbi8TditjTwdeB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFY4XoACgkQAVBC80lX
0Gxiwgf/emUO5IIiIm61dtXY7bC6BcDa1+b8CTRjOTsGOfFGUqPiJ8GdK6d0r6PJ
dT8+GtWpM3a8+xy6hF5w0kb1/fhIErfy55w2qqIIsklK0rq8oesadwry63i4GTAY
I7oyQWoPiukuEZnGo+57jxYhidDnL0KHQ6QcMWgUi+F6T63BFbWazHj54L6D3K9K
/THBvsdN7qt3MZ1Ci+qlhAoT4kkp///yl7j4aP2NJKN2nXz5Fo7QjKHXFbLjtj+T
RHBcZ5f+ceb9eohhPLBEQUoy5fzOwlOghwIZQiqRVwHyb3g5xiPrnjtYKc2+KkYp
Tmc+zpG6K8cz+7j8pPw4X4ja8SL1Xw==
=1SmH
-----END PGP SIGNATURE-----

--Sig_/oR.tVRCv.tbi8TditjTwdeB--
