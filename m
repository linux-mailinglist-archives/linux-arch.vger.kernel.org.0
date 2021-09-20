Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF4411AA3
	for <lists+linux-arch@lfdr.de>; Mon, 20 Sep 2021 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbhITQuw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Sep 2021 12:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244355AbhITQuH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Sep 2021 12:50:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AAC461213;
        Mon, 20 Sep 2021 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632156520;
        bh=JNFmVKopSY3zild0Tv3+xFBOULjKMkMEN821JJpnIGA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=FsUJa8pYj6IPl/aiRt9kaClSiVbeKeMxQS2AxyS01HnfWhRRTrlWxsEA9AsXVGtxS
         IYbW+bSCKk79VPwuYVEYNXYRl3lAt8wm1+gaLDEtVQm5CtCfZLnemlvPtNb2HszN70
         AZGDPXV0cb4pYY+7aOLZZfGBBJZozVfTAoP5RQhfNEcclljTbtswj6mxVoqMvzaUVB
         SeQTwCXwO6SUVlU2YiftoE5La9MdHw3Rp/mWhXZFLpy8JEdUYmP/twxXeOztxUY7Ee
         bgm+oL16xqPQ8E4ZN3+F6PD0pjHuuelx3EFFaJR3U83mxWxNsM71BIYM5vATkDhWUZ
         x1RWJU9sR1AYA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2D57927C005A;
        Mon, 20 Sep 2021 12:48:37 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Mon, 20 Sep 2021 12:48:37 -0400
X-ME-Sender: <xms:YrtIYUOTCuIT4q4qJwYGzgfWBqYr-zpR5kcX02t8OgaUfR876h2EFw>
    <xme:YrtIYa8BieKbTCcf2O_q8-evxBy66zCNK49kqFi5gi-AaE1J6qiOZBmG__C87mVNX
    qNUWJrnRubXXk7u3Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeivddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:YrtIYbRJjdLVd2SslELsb2LzJ7T5vsbKCMsHt50iRXG6H50Bh6WYfQ>
    <xmx:YrtIYcuFM-XUVyJsiQyiylvKnHoCPAY3VZUipXPh_sU1Jo54ZGY9_Q>
    <xmx:YrtIYccdjH5tsn67wtNSdMmikWEgmKkdksL6Wr7sKO5Ha08lJgO3hQ>
    <xmx:ZbtIYQ-vHq5NUKRU6PnOevwmtu3DRLhwx5WmzYWMrHfpRoah-UsoJTxwG7o>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EF814A03DC4; Mon, 20 Sep 2021 12:48:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1291-gc66fc0a3a2-fm-20210913.001-gc66fc0a3
Mime-Version: 1.0
Message-Id: <b5b5787b-17ce-4e66-8bc6-ab42ae3e398d@www.fastmail.com>
In-Reply-To: <45c62101c065ed7e728fadac7207866bf8c36ec4.camel@intel.com>
References: <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
 <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
 <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
 <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
 <20200901102758.GY6642@arm.com>
 <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
 <CALCETrWJQgtO_tP1pEaDYYsFgkZ=fOxhyTRE50THcxYoHyTTwg@mail.gmail.com>
 <32005d57-e51a-7c7f-4e86-612c2ff067f3@intel.com>
 <46dffdfd-92f8-0f05-6164-945f217b0958@intel.com>
 <ed929729-4677-3d3b-6bfd-b379af9272b8@intel.com>
 <6e1e22a5-1b7f-2783-351e-c8ed2d4893b8@intel.com>
 <5979c58d-a6e3-d14d-df92-72cdeb97298d@intel.com>
 <ab1a3344-60f4-9b9d-81d4-e6538fdcafcf@intel.com>
 <08c91835-8486-9da5-a7d1-75e716fc5d36@intel.com>
 <a881837d-c844-30e8-a614-8b92be814ef6@intel.com>
 <cbec8861-8722-ec31-2c02-1cfed20255eb@intel.com>
 <b3379d26-d8a7-deb7-59f1-c994bb297dcb@intel.com>
 <a1efc4330a3beff10671949eddbba96f8cde96da.camel@intel.com>
 <41aa5e8f-ad88-2934-6d10-6a78fcbe019b@intel.com>
 <CALCETrX5qJAZBe9sHL6+HFvre-bbo+us1==q9KHNCyRrzaUsjw@mail.gmail.com>
 <45c62101c065ed7e728fadac7207866bf8c36ec4.camel@intel.com>
Date:   Mon, 20 Sep 2021 09:48:10 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     "Balbir Singh" <bsingharora@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Jann Horn" <jannh@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Oleg Nesterov" <oleg@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Pavel Machek" <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "tarasmadan@google.com" <tarasmadan@google.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        "vedvyas.shanbhogue@intel.com" <vedvyas.shanbhogue@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Cyrill Gorcunov" <gorcunov@gmail.com>
Subject: =?UTF-8?Q?Re:_[NEEDS-REVIEW]_Re:_[PATCH_v11_25/25]_x86/cet/shstk:_Add_ar?=
 =?UTF-8?Q?ch=5Fprctl_functions_for_shadow_stack?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Mon, Sep 13, 2021, at 6:33 PM, Edgecombe, Rick P wrote:
> On Mon, 2020-09-14 at 11:31 -0700, Andy Lutomirski wrote:
> > > On Sep 14, 2020, at 7:50 AM, Dave Hansen <dave.hansen@intel.com>
> > > wrote:
> > >=20
> > > =EF=BB=BFOn 9/11/20 3:59 PM, Yu-cheng Yu wrote:
> > > ...
> > > > Here are the changes if we take the mprotect(PROT_SHSTK)
> > > > approach.
> > > > Any comments/suggestions?
> > >=20
> > > I still don't like it. :)
> > >=20
> > > I'll also be much happier when there's a proper changelog to
> > > accompany
> > > this which also spells out the alternatives any why they suck so
> > > much.
> > >=20
> >=20
> > Let=E2=80=99s take a step back here. Ignoring the precise API, what =
exactly
> > is
> > a shadow stack from the perspective of a Linux user program?
> >=20
> > The simplest answer is that it=E2=80=99s just memory that happens to=
 have
> > certain protections.  This enables all kinds of shenanigans.  A
> > program could map a memfd twice, once as shadow stack and once as
> > non-shadow-stack, and change its control flow.  Similarly, a program
> > could mprotect its shadow stack, modify it, and mprotect it back.  In
> > some threat models, though could be seen as a WRSS bypass.  (Although
> > if an attacker can coerce a process to call mprotect(), the game is
> > likely mostly over anyway.)
> >=20
> > But we could be more restrictive, or perhaps we could allow user code
> > to opt into more restrictions.  For example, we could have shadow
> > stacks be special memory that cannot be written from usermode by any
> > means other than ptrace() and friends, WRSS, and actual shadow stack
> > usage.
> >=20
> > What is the goal?
> >=20
> > No matter what we do, the effects of calling vfork() are going to be
> > a
> > bit odd with SHSTK enabled.  I suppose we could disallow this, but
> > that seems likely to cause its own issues.
>=20
> Hi,
>=20
> Resurrecting this old thread to highlight a consequence of the design
> change that came out of it. I am going to be taking over this series
> from Yu-cheng, and wanted to check if people would be interested in re-
> visiting this interface.
>=20
> The consequence I wanted to highlight, is that making userspace be
> responsible for mapping memory as shadow stack, also requires moving
> the writing of the restore token to userspace for glibc ucontext
> operations. Since these operations involve creating/pivoting to new
> stacks in userspace, ucontext cet support involves also creating a new
> shadow stack. For normal thread stacks, the kernel has always done the
> shadow stack allocation and so it is never writable (in the normal
> sense) from userspace. But after this change makecontext() now first
> has to mmap() writable memory, then write the restore token, then
> mprotect() it as shadow stack. See the glibc changes to support
> PROT_SHADOW_STACK here[0].
>=20
> The writable window leaves an opening for an attacker to create an
> arbitrary shadow stack that could be pivoted to later by tweaking the
> ucontext_t structure. To try to see how much this matters, we have done
> a small test that uses this window to ROP from writes in another
> thread during the makecontext()/setcontext() window. (offensive work
> credit to Joao on CC). This would require a real app to already to be
> using ucontext in the course of normal runtime.

My general opinion here (take this with a grain of salt -- I haven't pag=
ed back in every single detail) is that the kernel should make it straig=
htforward for a libc to do the right thing without nasty races, cross-th=
read coordination, or unnecessary permission to write to the stack.  I *=
also* think that it should be possible for userspace to manage its own s=
hadow stack allocation if it wants to, since I'm sure there will be JIT =
or green thread or other use cases that want to do crazy things that we =
fail to anticipate with in-kernel magic.

So perhaps we should keep the explicit allocation and free operations, h=
ave a way to opt-in to WRSS being flipped on, but also do our best to ha=
ve API that handle the known cases well.

Does that make sense?  Can we have both approaches work in the same kern=
el?
