Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1813EF442
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 22:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhHQUw4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 16:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhHQUwz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Aug 2021 16:52:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7633D60FD7;
        Tue, 17 Aug 2021 20:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629233541;
        bh=jtaJev2QUJEIL//Sa7qkQRM5UVkuG/GV/6sCBDB69YQ=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=EXUTMGcvqyfo0fqanbYsezZKOFdpg3HRdxAt0LvmEwLNzIu8wvsPzVfAoPcZc9IGM
         Wn7iyW4zf1Yh+a6uL9GqBHyZ6bVu+UxTjfuE3uMiziB4MOcZ3gL1NQwV3PorPXNCOj
         rpOaEQyylhfLSVyKqqmZXIdkwOrJ7mGvlfcmt8N0ZbaEzFUxAeevPtGRlHoTS3t7s/
         rSLdrJtTA8JEJwt9z6SU8wIB8m7WpxwCPkR34om4XeRZIIGVvZfg1hv8t7y5uAahqO
         f8dRRcUh1jFtm/Ijw3pumRDQsTg9NXOAorhhvQQaAcc1qnRzL50vir2hqecyZxg//f
         YzvkmjWWuASNQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 74F3427C0054;
        Tue, 17 Aug 2021 16:52:18 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Tue, 17 Aug 2021 16:52:18 -0400
X-ME-Sender: <xms:fSEcYeu4l5G7OQMAURqdCUo-R2sL5W3yqVi9Aig_gxvxg-5nxA9JDA>
    <xme:fSEcYTf6VtgnposqEhR-yt9hLGLpyLDyQxOnE-1HfRvra4prKVkPbrqGepbpedNCd
    XMzRgEVFDtF4v2R7Ik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleefgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepuefgueefveekhedvtdffgfekleehgfekheevteegieekgeehiedv
    fffgjeetudfhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:fSEcYZxL6pWWXxK3vzGs7QTvuLNYNse4RWzk5hq7HiJ7DpBW0_VP5A>
    <xmx:fSEcYZPFY5WRAigCyxiZqS8sNuq5AdEwQ9dr0D7eH2qFlS1D4Hc6qw>
    <xmx:fSEcYe_1xBgT81Ia_BysQPp8RbWEOGT7kqZlzpoGBUc2QIYokZlbGA>
    <xmx:giEcYX2SAYNKuh6NimWAkH0gpWXsp9g3sY99BkJTCpj8QbuboeAnqeHQzAQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D5CC2A038A7; Tue, 17 Aug 2021 16:52:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1118-g75eff666e5-fm-20210816.002-g75eff666
Mime-Version: 1.0
Message-Id: <490345b6-3e3d-4692-8162-85dcb71434c9@www.fastmail.com>
In-Reply-To: <YRwbD1hCYFXlYysI@zn.tnic>
References: <YRwT7XX36fQ2GWXn@zn.tnic>
 <1A27F5DF-477B-45B7-AD33-CC68D9B7CB89@amacapital.net>
 <YRwbD1hCYFXlYysI@zn.tnic>
Date:   Tue, 17 Aug 2021 13:51:52 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Borislav Petkov" <bp@alien8.de>,
        "luto@amacapital.net" <luto@amacapital.net>
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Balbir Singh" <bsingharora@gmail.com>,
        "Cyrill Gorcunov" <gorcunov@gmail.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, "Jann Horn" <jannh@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Kees Cook" <keescook@chromium.org>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Oleg Nesterov" <oleg@redhat.com>, "Pavel Machek" <pavel@ucw.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        "Pengfei Xu" <pengfei.xu@intel.com>,
        "Haitao Huang" <haitao.huang@intel.com>,
        "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v28 09/32] x86/mm: Introduce _PAGE_COW
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 17, 2021, at 1:24 PM, Borislav Petkov wrote:
> On Tue, Aug 17, 2021 at 01:13:09PM -0700, Andy Lutomirski wrote:
> > > If special kernel code using shadow stack management insns needs
> > > to modify a shadow stack, then it can check whether a page is
> > > pte/pmd_shstk() but that code is special anyway.
> > >=20
> > > Hell, a shadow stack page is (Write=3D0, Dirty=3D1) so calling it =
writable
> > >                  ^^^^^^^
> > > is simply wrong.
> >=20
> > But it *is* writable using WRUSS, and it=E2=80=99s also writable by =
CALL,
>=20
> Well, if we have to be precise, CALL doesn't write it directly - it
> causes for shadow stack to be written as part of CALL's execution. Yeah
> yeah, potato potato.

Potahto.

>=20
> > WRSS, etc.
>=20
> Thus the "special kernel code" thing above. I've left it in instead of
> snipping it.
>=20

WRSS can be used from user mode depending on the configuration.

> > Now if the mm code tries to write protect it and expects sensible
> > semantics, the results could be interesting. At the very least,
> > someone would need to validate that RET reading a read only shadow
> > stack page does the right thing.
>=20
> Huh?
>=20
> A shadow stack page is RO (W=3D0).

Double-you shmouble-you.  You can't write it with MOV, but you can write=
 it from user code and from kernel code.  As far as the mm is concerned,=
 I think it should be considered writable.

Although... anyone who tries to copy_to_user() it is going to be a bit s=
urprised.  Hmm.

>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette
>=20
