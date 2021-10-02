Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F034A41FEBF
	for <lists+linux-arch@lfdr.de>; Sun,  3 Oct 2021 01:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhJBXnC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 19:43:02 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:55511 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhJBXnB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 19:43:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HMNll5JY5z4xLs;
        Sun,  3 Oct 2021 10:41:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1633218073;
        bh=h5rCfWVd2KAS1r0rx/4MyeNOm0KXGCv7ei1Oa3wfVw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LR9XvwNWo52I8k8xV1ARFIY3gZCD6/3fjo9CQhO0P6jaKRMszMFIL9bWLhh5iHw0q
         UHI2kDxGx1bMKWBNHrBp7vyYxW4DB20WArsVI1kDqdO7+0ghnrMEG4K/yb7+LvTwBn
         toMSTxPFapsEexWZp/qdWSTAlR/D4/Okbw7UJ9E7Wa23OVSX84UUlHu82Aj8bm8gOQ
         ThsZMc01DLr77Asp89OT4VFUxxBLN+Y+e6SBiCL90Jtjex4R5Tmr24TCfkIDfGv451
         a9P2jZ3BOQozarZeeuXvTI2lmn7rO4tPUj5/hnApbqIEbaANHaSK8XxZoti6ar9Lpw
         dnZNNNZseg4Aw==
Date:   Sun, 3 Oct 2021 10:41:06 +1100
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
Message-ID: <20211003104106.1526fa31@canb.auug.org.au>
In-Reply-To: <YVjm3NXEhoBQtUSI@yury-ThinkPad>
References: <20211001181245.228419-1-yury.norov@gmail.com>
        <20211003094722.434c030d@canb.auug.org.au>
        <YVjm3NXEhoBQtUSI@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kAlpOp8EAy3Kn/awCgiF/9z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/kAlpOp8EAy3Kn/awCgiF/9z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Sat, 2 Oct 2021 16:10:20 -0700 Yury Norov <yury.norov@gmail.com> wrote:
>
> Ok, I'll resend it based on Linus tree shortly

Thanks.

I also need a branch name that will stay the same.  I will fetch that
branch every day and use whatever you have set that branch to.

Here are the rules for inclusion in linux-next:

You will need to ensure that the commits in your tree/branch have
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

--Sig_/kAlpOp8EAy3Kn/awCgiF/9z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFY7hMACgkQAVBC80lX
0Gyudgf/duBmonArREDWPtOW4lp51VabyQLx+hZYJ+Q1auyILQqUEA2zzIxjOlcr
Q9PeQKO7pqN8v6Cy8BW1ObVXhQDCrgfWgAXxv+E3r3DuiybqvfhXGh+33dcs339/
ASl5rj/Wg3L3deEtupNsN2kvN0bjnrBP2b/1FeTPWCrhq/JCHiH2hM1NDJ9BzXzM
jBDYxqlAwxPxWq4IcOFu/rq9Sykml+ROpOnKcKf72d60WcJUsG9HtWZZjy/FbKym
2R+EwahIb8SXCFmsAPmWuCwcQMAz/m/OH91/VZ9Es8X9ef+MlWMQpg94hw3JlMrP
e33F7MaTTKnxgbRK/TW8ReYml2wriA==
=NPVY
-----END PGP SIGNATURE-----

--Sig_/kAlpOp8EAy3Kn/awCgiF/9z--
