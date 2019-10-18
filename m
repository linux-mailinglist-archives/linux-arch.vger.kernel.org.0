Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87A0DBE7E
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 09:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfJRHhk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 03:37:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37236 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbfJRHhk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 03:37:40 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iLMoG-0004PG-JE; Fri, 18 Oct 2019 18:36:29 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Oct 2019 18:36:16 +1100
Date:   Fri, 18 Oct 2019 17:56:23 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Slaby <jslaby@suse.cz>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Juergen Gross <jgross@suse.com>, linux-crypto@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-efi@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v9 24/28] x86_64/asm: Change all ENTRY+ENDPROC to
 SYM_FUNC_*
Message-ID: <20191018065623.GA15199@gondor.apana.org.au>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-25-jslaby@suse.cz>
 <20191016071230.GD1138@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016071230.GD1138@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 16, 2019 at 09:12:30AM +0200, Borislav Petkov wrote:
> Hi,
> 
> On Fri, Oct 11, 2019 at 01:51:04PM +0200, Jiri Slaby wrote:
> > These are all functions which are invoked from elsewhere, so annotate
> > them as global using the new SYM_FUNC_START. And their ENDPROC's by
> > SYM_FUNC_END.
> > 
> > And make sure ENTRY/ENDPROC is not defined on X86_64, given these were
> > the last users.
> > 
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> [hibernate]
> > Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com> [xen bits]
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: x86@kernel.org
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Matt Fleming <matt@codeblueprint.co.uk>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: linux-crypto@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-efi@vger.kernel.org
> > Cc: xen-devel@lists.xenproject.org
> > ---
> >  arch/x86/boot/compressed/efi_thunk_64.S      |  4 +-
> >  arch/x86/boot/compressed/head_64.S           | 16 +++---
> >  arch/x86/boot/compressed/mem_encrypt.S       |  8 +--
> >  arch/x86/crypto/aegis128-aesni-asm.S         | 28 ++++-----
> >  arch/x86/crypto/aes_ctrby8_avx-x86_64.S      | 12 ++--
> >  arch/x86/crypto/aesni-intel_asm.S            | 60 ++++++++++----------
> >  arch/x86/crypto/aesni-intel_avx-x86_64.S     | 32 +++++------
> >  arch/x86/crypto/blowfish-x86_64-asm_64.S     | 16 +++---
> >  arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 24 ++++----
> >  arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 24 ++++----
> >  arch/x86/crypto/camellia-x86_64-asm_64.S     | 16 +++---
> >  arch/x86/crypto/cast5-avx-x86_64-asm_64.S    | 16 +++---
> >  arch/x86/crypto/cast6-avx-x86_64-asm_64.S    | 24 ++++----
> >  arch/x86/crypto/chacha-avx2-x86_64.S         | 12 ++--
> >  arch/x86/crypto/chacha-avx512vl-x86_64.S     | 12 ++--
> >  arch/x86/crypto/chacha-ssse3-x86_64.S        | 12 ++--
> >  arch/x86/crypto/crc32-pclmul_asm.S           |  4 +-
> >  arch/x86/crypto/crc32c-pcl-intel-asm_64.S    |  4 +-
> >  arch/x86/crypto/crct10dif-pcl-asm_64.S       |  4 +-
> >  arch/x86/crypto/des3_ede-asm_64.S            |  8 +--
> >  arch/x86/crypto/ghash-clmulni-intel_asm.S    |  8 +--
> >  arch/x86/crypto/nh-avx2-x86_64.S             |  4 +-
> >  arch/x86/crypto/nh-sse2-x86_64.S             |  4 +-
> >  arch/x86/crypto/poly1305-avx2-x86_64.S       |  4 +-
> >  arch/x86/crypto/poly1305-sse2-x86_64.S       |  8 +--
> >  arch/x86/crypto/serpent-avx-x86_64-asm_64.S  | 24 ++++----
> >  arch/x86/crypto/serpent-avx2-asm_64.S        | 24 ++++----
> >  arch/x86/crypto/serpent-sse2-x86_64-asm_64.S |  8 +--
> >  arch/x86/crypto/sha1_avx2_x86_64_asm.S       |  4 +-
> >  arch/x86/crypto/sha1_ni_asm.S                |  4 +-
> >  arch/x86/crypto/sha1_ssse3_asm.S             |  4 +-
> >  arch/x86/crypto/sha256-avx-asm.S             |  4 +-
> >  arch/x86/crypto/sha256-avx2-asm.S            |  4 +-
> >  arch/x86/crypto/sha256-ssse3-asm.S           |  4 +-
> >  arch/x86/crypto/sha256_ni_asm.S              |  4 +-
> >  arch/x86/crypto/sha512-avx-asm.S             |  4 +-
> >  arch/x86/crypto/sha512-avx2-asm.S            |  4 +-
> >  arch/x86/crypto/sha512-ssse3-asm.S           |  4 +-
> >  arch/x86/crypto/twofish-avx-x86_64-asm_64.S  | 24 ++++----
> >  arch/x86/crypto/twofish-x86_64-asm_64-3way.S |  8 +--
> >  arch/x86/crypto/twofish-x86_64-asm_64.S      |  8 +--
> 
> I could use an ACK for the crypto bits...

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
