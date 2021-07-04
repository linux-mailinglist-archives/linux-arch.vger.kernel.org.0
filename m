Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7B53BAD4A
	for <lists+linux-arch@lfdr.de>; Sun,  4 Jul 2021 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGDOFT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Jul 2021 10:05:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:51737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhGDOFT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 4 Jul 2021 10:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625407285;
        bh=qCFNx0oWRTXt6mjRNsgYCCM5WwpT+/4HKI7MSDuJJGE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GklD0Tma/lx/2AV87ghdg/Qze0ZAKuGkX3qFSJVk1o/IAwlMlnA3M/WPBzBILFQ60
         C1yaHfqDLcvlOWqERXxDmrixxX7IdAyTEOuIMsHVKAIAkcHmuP2maVvWg7S2usjrCj
         SBz7OW0ip3Ekvys5cp49IWRkdbd4IZp4BUgIUXPo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.228.41]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOREc-1lqjIh1CsY-00Pvaw; Sun, 04
 Jul 2021 16:01:25 +0200
Date:   Sun, 4 Jul 2021 16:01:08 +0200
From:   John Wood <john.wood@gmx.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>,
        valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v8 3/8] security/brute: Detect a brute force attack
Message-ID: <20210704140108.GA2742@ubuntu>
References: <20210701234807.50453-1-alobakin@pm.me>
 <20210702145954.GA4513@ubuntu>
 <20210702170101.16116-1-alobakin@pm.me>
 <20210703105928.GA2830@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210703105928.GA2830@ubuntu>
X-Provags-ID: V03:K1:Zlv/I3jSwhQHOVW60yI8jrDAcYgbYRJ0DR/nPSVeP8thlzpNyfP
 Iy4q/M6ejxhwDhZ87s3DfnCTgkAHBDLbzMX83gQOaCGeWDPFYHbSWc85q8H4B1p3bXLckjH
 c0BJ7pVpncMao1CZjr+hoU910ZdvL1AqNB1/t+dmP8YygFdNwosY681NLG+78hFRzCXk+OU
 edDRLEmHS5NdCtwr4DiGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xu4NXV3hBGY=:9VsIzecylfJIkNr7kTE/xd
 ffa1w/cSXPBVUdHerWPnISoMh/XoptArz8co14byqOziF831kzJj5nZ0fqnysCK1knBArVSy9
 nJjYWf9H8MFohHQreGRWofJmr+quGvrdv4PspoXMpZ55zWoqDS1cx/hdkEPja9U1FGP0jTNbq
 F1FB23qrEMmaZjzdp5hb47mkVcuD3c+XgJFre2T9ecG9VQ1BGQHLfj7RKDlc6kgG46ziYRVbj
 +j2R5Rz9beIJowdvTFsCc7Gpxu6zHpcaQnbggqAVj8dVAGJAawmEsSEvnuEMgQVY3OlBRDbKQ
 sahHpkKLopj+42BewBHYOQfAWC7jnHHkPVJX0ebUoePyw+X/TxJMpB5172IJMerGm6fFt2rKj
 uV/q2xtXoQnWQCyLtiemxIi+r+8zVa5HKMJCjMq+HBgh2Gy1L5WXTSSg411UL+xcJMjiSP1vy
 IwGaAB7CalqbdNFQA6x39qteGEZvMckOJK1LatX5Gr5nKsLVcH2TdpnFqVCe/kO1zMUPwBRQo
 bMlYCnMorKCthiiRbEfJ/QV+GsbbmwXB54JiD+uDgrlRQvCIx7iB1hisDMktSPGaDxtXWHhgc
 +E7Kj6yjWk6j6B/CVdBKcv8Se1229GE3CpMMSZZQoB93OuYdiRJMCd1CAN/WSe+6ap5lapb20
 n/JshVmBqy3Kfli935tFYBShyVW1fi1gPOFtcYkmbU83m3D66n74PgduHWWG++ucFfchYF/OD
 wxIdKMSOfy/cER6z5IbzstOTJTr19zJUJugflt4bVjC1XORzWH3ZUBN6rY744cJRk7yaAMB72
 tXFj68NKVbRGN/qD15QyYGhZiCyLP9gsaEwibZxiP72wCYuPp/DSOZcSFSLgKbJKJbfQRXwrz
 N8KRvHz3PlzzWepKE1jLm2wl6reYqaCCUgodX4rrm5qEhz7t2tMRoNBoSV7QhvClXN/p2enTv
 a0UIHvFDqstk0cHFyNhqrj4SDal/dIwQccXgNVznb+TX3Oj7Uc64rawV1TqpZUEO4FlVuG2Ai
 DT8WAFrJrQ/4XHfCqkM19Rc6Q7UFg0O77mph7SYJ+ixe7DcHrTQY/RjgcCx/e9gtIeZoU1pdM
 PH5NRowdVQ6az2dzeSJ9Bc+HKoQBGly9Alu
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 03, 2021 at 12:59:28PM +0200, John Wood wrote:
> Hi,
>
> On Fri, Jul 02, 2021 at 05:08:09PM +0000, Alexander Lobakin wrote:
> >
> > On the other hand, it leaves a potentional window for attackers to
> > perform brute force from xattr-incapable filesystems. So at the end
> > of the day I think that the current implementation (a strong
> > rejection of such filesystems) is way more secure than having
> > a fallback I proposed.
>
> I've been thinking more about this: that the Brute LSM depends on xattr
> support and I don't like this part. I want that brute force attacks can
> be detected and mitigated on every system (with minimal dependencies).
> So, now I am working in a solution without this drawback. I have some
> ideas but I need to work on it.

I have been coding and testing a bit my ideas but:

Trying to track the applications faults info using kernel memory ends up
in an easy to abuse system (denied of service due to large amount of memor=
y
in use) :(

So, I continue with the v8 idea: xattr to track application crashes info.

> > I'm planning to make a patch which will eliminate such weird rootfs
> > type selection and just always use more feature-rich tmpfs if it's
> > compiled in. So, as an alternative, you could add it to your series
> > as a preparatory change and just add a Kconfig dependency on
> > CONFIG_TMPFS && CONFIG_TMPFS_XATTR to CONFIG_SECURITY_FORK_BRUTE
> > without messing with any fallbacks at all.
> > What do you think?
>
> Great. But I hope this patch will not be necessary for Brute LSM :)

My words are no longer valid ;)

Thanks,
John Wood
