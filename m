Return-Path: <linux-arch+bounces-10049-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380BBA2C04D
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 11:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31160188BCDC
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2408C18FDD5;
	Fri,  7 Feb 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JQrCMHr2"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E291624ED;
	Fri,  7 Feb 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923411; cv=none; b=G8J/i2ZSkeke7Tw0Xr8WMJvM+7ie17x2veVsGIZJl/aotM1VT2qpG9bHPsZcOFL+AYvA8ew7m4KSB7/NBMZn30jYJaSR9oIvQMlVnjFSNp6d10nPUzMWfmokyxVcaH5jTXZysNMNXDvZgySyyS1PFLz9ClhNsz/4QbND7mT0Y5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923411; c=relaxed/simple;
	bh=zVqX9Hq16/SBdTp2H/rBCvE55Od/Y0deJt0gh/PTA4k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ITburXgrMS2Cbx5vev5S2mZqisgnBPQzO3Ox9aSktHwMpMAHNpNXNEcCLid5CDUZ+HstoOHlxMM39Pn6j5awmIjwHzqL0Ai4sHqSK/w47m2RBbWoVw1Pn/MNXNiRBkCRid7rXuHK0Fs7wR26PtVWsJ4xZ9L6I+X0Z6etqPv/s/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JQrCMHr2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zVqX9Hq16/SBdTp2H/rBCvE55Od/Y0deJt0gh/PTA4k=; b=JQrCMHr2BdrjS4NKrzUQ4brppT
	UggDTJnj1TCbsw8d6uS/TP1LXzuCYCRpzvxXY3M1Udn1/rpXKT+D2yISKc9EHbbjlk1JMiwjezT0w
	G/g1Rm0utnZUcDsOAhllHICdtEJxIYMJw/XeRN/mslhRg1XxSlNHhBbjnLxUXcGhEAIUycfIHwyAz
	ItWZqc3X+RpAaZKfd7tucO6DvzefcQn0FPMOPsZAyCKizC/2AjVKxERO5/VgZ3Cnr4Chc1uCRoERY
	AxTesLAbLLvoSEfjxsUL7zWXl8QA3C30qYHv/EpdvBIOHqKBDnTg+VDWbD2Y+xZaag8m8LicEjrBB
	LIoBs9Rw==;
Received: from 54-240-197-238.amazon.com ([54.240.197.238] helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tgLOp-00000007cdM-31OR;
	Fri, 07 Feb 2025 10:15:52 +0000
Message-ID: <0a6b88c0edd85a2ae0886e5454afea09cfcd3a24.camel@infradead.org>
Subject: Re: [PATCH v3 00/18] vDSO: Introduce generic data storage
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge
 Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>,  Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>,  "Jason A. Donenfeld" <Jason@zx2c4.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Russell King <linux@armlinux.org.uk>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,  Arnd Bergmann
 <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, linux-parisc@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, Nam Cao
 <namcao@linutronix.de>, linux-csky@vger.kernel.org, "Ridoux, Julien"
 <ridouxj@amazon.com>, "Luu, Ryan" <rluu@amazon.com>, kvm
 <kvm@vger.kernel.org>
Date: Fri, 07 Feb 2025 10:15:49 +0000
In-Reply-To: <20250206110648-ec4cf3d0-0aef-4feb-a859-c69e53ab110c@linutronix.de>
References: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
	 <ff83dc5c91b4e46bcf2d99680ec6af250fb05b27.camel@infradead.org>
	 <20250206110648-ec4cf3d0-0aef-4feb-a859-c69e53ab110c@linutronix.de>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-Hn9nn97uh7ZrvK5eTG4M"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-Hn9nn97uh7ZrvK5eTG4M
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-02-06 at 11:59 +0100, Thomas Wei=C3=9Fschuh wrote:
> On Thu, Feb 06, 2025 at 09:31:42AM +0000, David Woodhouse wrote:
> > On Tue, 2025-02-04 at 13:05 +0100, Thomas Wei=C3=9Fschuh wrote:
> > > Currently each architecture defines the setup of the vDSO data page o=
n
> > > its own, mostly through copy-and-paste from some other architecture.
> > > Extend the existing generic vDSO implementation to also provide gener=
ic
> > > data storage.
> > > This removes duplicated code and paves the way for further changes to
> > > the generic vDSO implementation without having to go through a lot of
> > > per-architecture changes.
> > >=20
> > > Based on v6.14-rc1 and intended to be merged through the tip tree.
>=20
> Note: The real answer will need to come from the timekeeping
> maintainers, my personal two cents below.
>=20
> > Thanks for working on this. Is there a plan to expose the time data
> > directly to userspace in a form which is usable *other* than by
> > function calls which get the value of the clock at a given moment?
>=20
> There are no current plans that I am aware of.
>=20
> > For populating the vmclock device=C2=B9 we need to know the actual
> > relationship between the hardware counter (TSC, arch timer, etc.) and
> > real time in order to propagate that to the guest.
> >=20
> > I see two options for doing this:
> >=20
> > =C2=A01. Via userspace, exposing the vdso time data (and a notification=
 when
> > =C2=A0=C2=A0=C2=A0 it changes?) and letting the userspace VMM populate =
the vmclock.
> > =C2=A0=C2=A0=C2=A0 This is complex for x86 because of TSC scaling; in f=
act userspace
> > =C2=A0=C2=A0=C2=A0 doesn't currently know the precise scaling from host=
 to guest TSC
> > =C2=A0=C2=A0=C2=A0 so we'd have to be able to extract that from KVM.
>=20
> Exposing the raw vdso time data is problematic as it precludes any
> evolution to its datastructures, like the one we are currently doing.
>=20
> An additional, trimmed down and stable data structure could be used.
> But I don't think it makes sense. The vDSO is all about a stable
> highlevel function interface on top of an unstable data interface.
> However the vmclock needs the lowlevel data to populate its own
> datastructure, wrapping raw data access in function calls is unnecessary.
> If no functions are involved then the vDSO is not needed. The data can
> be maintained separately in any other place in the kernel and accessed
> or mapped by userspace from there.
> Also the vDSO does not have an active notification mechanism, this would
> probably be implemented through a filedescriptor, but then the data
> can also be mapped through exactly that fd.
>=20
> > =C2=A02. In kernel, asking KVM to populate the vmclock structure much l=
ike
> > =C2=A0=C2=A0=C2=A0 it does other pvclocks shared with the guest. KVM/x8=
6 already uses
> > =C2=A0=C2=A0=C2=A0 pvclock_gtod_register_notifier() to hook changes; sh=
ould we expand
> > =C2=A0=C2=A0=C2=A0 on that? The problem with that notifier is that it s=
eems to be
> > =C2=A0=C2=A0=C2=A0 called far more frequently than I'd expect.
>=20
> This sounds better, especially as any custom ABI from the host kernel to
> the VMM would look a lot like the vmclock structure anyways.
>=20
> Timekeeper updates are indeed very frequent, but what are the concrete
> issues? That frequency is fine for regular vDSO data page updates,
> updating the vmclock data page should be very similar.
> The timekeeper core can pass context to the notifier callbacks, maybe
> this can be used to skip some expensive steps where possible.

In the context of a hypervisor with lots of guests running, that's a
lot of pointless steal time. But it isn't just that; ISTR the result
was also *inaccurate*.

I need to go back and reproduce the testing, but I think it was
constantly adjusting the apparent rate even with no changed inputs from
NTP. Where the number of clock counts per jiffy wasn't an integer, the
notification would be constantly changing, for example to report 333333
counts per jiffy for most of the time, and occasionally 333334 counts
for a single jiffy before flipping back again. Or something like that.

--=-Hn9nn97uh7ZrvK5eTG4M
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNzEwMTU0
OVowLwYJKoZIhvcNAQkEMSIEIERXi00+3GDk2E/p6131tegJ6jUhnrs0V9vxaiV5oZ2XMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIASTyZ34SddFoE
ocWSro73fUQgm5VHgrWVDJcQemFDotkX4gb22kx5AhMW01xylurQU2KXW1YBEOQIrP3o8Unp//jv
n1kL/lZCEQLr0AVvHWzJz+r9T8YOOPqhuYjKTYH7bNJRf4JCovNzSXRbz6r0HtGf8/T5L+H4YdVg
cEvCs/NnayU/HPIJEpncwWHDx+AuOts+aQ0/GnEI0Q+xZwDfCjrAZkrlMsSDd7WAdz0wwEt2uOEL
eIBW+5nm/AhsNZfMrvIvoMNGudPj9RQuIQkl0bIB4TTBXEeHkyyqJKn7BDoChI/IyhAo43sGyeUx
arvfQRzzlDeynusz+WVmgHFGQuiYr5BCqxvXomKqLaBMwv1kL//ffVhlw70jvv93NcISjRnvGgyJ
QZZ0xxvfNid8xUMEnTAG0qXP77EBjLtcRC5ZCc1XO4Td6yRL1F3/zGUrERW7Zh+hOCtXW+GBOiOQ
NidHrdr1VlFHbRv3/Q2TLePMD1j5WZp1sViLkBGiEsPa90DkKH0Si/t+h0ah+3+ONkNPMmhF5M+l
7U+enM1hpdV4KIKxun/YRp3rWBOan4WThApe5yvo3ZJj6+4/qUOP9olIeBZwkGhv9gvyDBOtmkcm
east0DnR7g7xSW1IhsmWjlSxM5cXw+ENzQ9+gYLa/jGq/5j6aCTvGXjG+71FaQEAAAAAAAA=


--=-Hn9nn97uh7ZrvK5eTG4M--

