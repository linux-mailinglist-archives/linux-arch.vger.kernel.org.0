Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929263BA84D
	for <lists+linux-arch@lfdr.de>; Sat,  3 Jul 2021 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhGCLDm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Jul 2021 07:03:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:53219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhGCLDm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 3 Jul 2021 07:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625309984;
        bh=x6a2MKj2i7ny1X6EqqStry+6FExFMd0ABQRz2nQeLYo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Wiw7YHneNAj0vRJgTC3prnFX86jII+xEDVN++I+m01JfvLFWKYMxNJThVpPmfNaMr
         0l1XkxxecRdMGd/ExVwB/L5tXY2XP/EGhE0aQbXZspLThbZgfj0sACe7WncRlHxXDF
         B6jPov8MEaN5iDIh2XMcRMHpdZpAmshp2gYuSPWM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.228.41]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC34X-1luSIn2S7R-00CSAc; Sat, 03
 Jul 2021 12:59:44 +0200
Date:   Sat, 3 Jul 2021 12:59:28 +0200
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
Message-ID: <20210703105928.GA2830@ubuntu>
References: <20210701234807.50453-1-alobakin@pm.me>
 <20210702145954.GA4513@ubuntu>
 <20210702170101.16116-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702170101.16116-1-alobakin@pm.me>
X-Provags-ID: V03:K1:IYa/f7HkDU74IlmbpIDqxZ4UnHLocuh2xK/SRcmGwjgHVE0HPwO
 uvk+ZKPo3XYM/EQ0BhfLQneFfb/z4C4sbQPYymJxVpCLHfTj4keZV746Dag/i+ohT+Tx1/V
 AzMPePnTmSZE/IiVBtMBldhthrEDhpmLHPUvlxEw3x6L7ewUJ/S8yXJnOJgUuMKIApCRwsB
 4agKpfVPAEAY+DauJZ2HA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DDK8tn1k2vk=:EF86SSfY5Vi1KOs8AADY/a
 3Cq2nb4xqxxZWH6qOL0VjCqZO9d4DZ7Xx/yAQlHXGZaBU+BQ//fuZI6ljkHqeWhwUkyLivscc
 qJgrFJ313EhAax10IlN6i1M2HXjw7HFxHekHYXtWwHUYHiWGVHeFwp3HWdCHEbX21FM/z6bXL
 zbscFiWSbWbcUUPbI4VBKkn12UFjq4r/w+sJ3Wkjny6xTDMx8wbkpoSBxAt0PC2QPFtFZPuM2
 sSm+saVCm0M1Eiqc9eizWMW64iyInEgBFtl/OJgcUzWq32x9bffwJ2rRgCSnXY24TrNgA0eo9
 JuqFZjKk3zr/20QNa8alL/Szxz+uUm5vc26NKd1EUyj67cJ+MxBKjcZfRJ4UMeSWIz2rK2H/Y
 uNP6v0PiZxFM2+MrI8UWw4WB74DT8jySibpghnRylZJs0Zpxj488MnwjJpEcugPNQyH6TkvoV
 XyV+/H9qAca+7u803Q3j9Vd/CFiLjyg7/nNcVpWALQe2Yu6R/6OE8VjwSTFFj37xS7ZDhtQ29
 xdJuoIZO7calbQyUhmUsCL2R38DX+T5ozjbZMc9nKiaTIWhqS70cw/HDnyAi+SYt+STd8Dc3h
 xeIMzJmj5dh47yDhj3YDLxvhLR1toQzatbzLPCnFzt8FflC/wTt5aLeCUlhgUjQXmEqCPKtKb
 7klmaSE/q595gmB8f2vi9R2LVvqG1UnyniXMCPW8nK0M0fLu4A45lUI3YpltthQPiHyO6nFKq
 Q/EeJiCLhjlyXwrEVTEE0KXA0n7zeYn6YN8h+xbC5dVYHOuiyi/eHBVur9KI9YV8lvxIYngGL
 VhgBJG4qW9KikFkNqMW1vmycs/t4n3KK0LaIZ0mIWF9WbTi7L5Vmd5EddLHnus9fnZQ9uUMcJ
 Knw313I1cIzVHCWrbb2vGYEOmMWa+3833cxeeRkazB2b9GD8HV4otN6tlw0/5zPjSVSoNlDhn
 Vevn56H0Y2whovHFCeakw8UqVk0gBkGsJSAMKzdVigvQcZYJ1B2lvCBf4/KiJYCrBwLPc0M/t
 CVgINq6H165/dOQ56gS1Fn1YxsFGT8XM0HMzCXZPplvjeA2uDcschlVNk3gPtiXpax5kZoD76
 SG2hbzUGdtKbMfttCXBP3mz/FXlbgtHans7
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Fri, Jul 02, 2021 at 05:08:09PM +0000, Alexander Lobakin wrote:
>
> On the other hand, it leaves a potentional window for attackers to
> perform brute force from xattr-incapable filesystems. So at the end
> of the day I think that the current implementation (a strong
> rejection of such filesystems) is way more secure than having
> a fallback I proposed.

I've been thinking more about this: that the Brute LSM depends on xattr
support and I don't like this part. I want that brute force attacks can
be detected and mitigated on every system (with minimal dependencies).
So, now I am working in a solution without this drawback. I have some
ideas but I need to work on it.

> I'm planning to make a patch which will eliminate such weird rootfs
> type selection and just always use more feature-rich tmpfs if it's
> compiled in. So, as an alternative, you could add it to your series
> as a preparatory change and just add a Kconfig dependency on
> CONFIG_TMPFS && CONFIG_TMPFS_XATTR to CONFIG_SECURITY_FORK_BRUTE
> without messing with any fallbacks at all.
> What do you think?

Great. But I hope this patch will not be necessary for Brute LSM :)

Thanks,
John Wood
