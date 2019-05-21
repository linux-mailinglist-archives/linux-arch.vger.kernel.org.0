Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7688825A35
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2019 00:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfEUWAW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 May 2019 18:00:22 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:46438 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfEUWAW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 May 2019 18:00:22 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 054F172CCD5;
        Wed, 22 May 2019 01:00:21 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id E72DD7CC6FF; Wed, 22 May 2019 01:00:20 +0300 (MSK)
Date:   Wed, 22 May 2019 01:00:20 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        strace-devel@lists.strace.io
Subject: Re: strace for m68k bpf_prog_info mismatch
Message-ID: <20190521220020.GA13769@altlinux.org>
References: <874l6c89nd.fsf@tarshish>
 <CAMuHMdUT3ug+SCzrnA2eD=QyOLaHUGAe-ZrbWfDUWxTJ4CWEtQ@mail.gmail.com>
 <8736lv92ls.fsf@tarshish>
 <CAMuHMdXooXuk8q1zC+KM==BiWPn9usWR6oM7xQ5VzwT6bjzcqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXooXuk8q1zC+KM==BiWPn9usWR6oM7xQ5VzwT6bjzcqg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Baruch, Geert,

Could you share these findings with bpf and netdev people, please?

On Fri, May 03, 2019 at 02:16:04PM +0200, Geert Uytterhoeven wrote:
> Hi Baruch,
>=20
> On Fri, May 3, 2019 at 1:52 PM Baruch Siach <baruch@tkos.co.il> wrote:
> > On Fri, May 03 2019, Geert Uytterhoeven wrote:
> > > On Fri, May 3, 2019 at 6:06 AM Baruch Siach <baruch@tkos.co.il> wrote:
> > >> strace 5.0 fails to build for m86k/5208 with the Buildroot generated
> > >> toolchain:
> > >>
> > >> In file included from bpf_attr_check.c:6:0:
> > >> static_assert.h:20:25: error: static assertion failed: "bpf_prog_inf=
o_struct.nr_jited_ksyms offset mismatch"
> > >>  #  define static_assert _Static_assert
> > >>                          ^
> > >> bpf_attr_check.c:913:2: note: in expansion of macro =E2=80=98static_=
assert=E2=80=99
> > >>   static_assert(offsetof(struct bpf_prog_info_struct, nr_jited_ksyms=
) =3D=3D offsetof(struct bpf_prog_info, nr_jited_ksyms),
> > >>   ^~~~~~~~~~~~~
> > >>
> > >> The direct cause is a difference in the hole after the gpl_compatible
> > >> field. Here is pahole output for the kernel struct (from v4.19):
> > >>
> > >> struct bpf_prog_info {
> > >>         ...
> > >>         __u32                      ifindex;              /*    80   =
  4 */
> > >>         __u32                      gpl_compatible:1;     /*    84: 0=
  4 */
> > >>
> > >>         /* XXX 15 bits hole, try to pack */
> > >>         /* Bitfield combined with next fields */
> > >>
> > >>         __u64                      netns_dev;            /*    86   =
  8 */
> > >
> > > I guess that should be "__aligned_u64 netns_dev;", to not rely on
> > > implicit alignment.
> >
> > Thanks. I can confirm that this minimal change fixes strace build:
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 929c8e537a14..709d4dddc229 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -2869,7 +2869,7 @@ struct bpf_prog_info {
> >         char name[BPF_OBJ_NAME_LEN];
> >         __u32 ifindex;
> >         __u32 gpl_compatible:1;
> > -       __u64 netns_dev;
> > +       __aligned_u64 netns_dev;
> >         __u64 netns_ino;
> >         __u32 nr_jited_ksyms;
> >         __u32 nr_jited_func_lens;
> >
> > Won't that break ABI compatibility for affected architectures?
>=20
> Yes it will. Or it may have been unusable without the fix. I don't know
> for sure.
>=20
> > >> And this is for the strace struct:
> > >>
> > >> struct bpf_prog_info_struct {
> > >>         ...
> > >>         uint32_t                   ifindex;              /*    80   =
  4 */
> > >>         uint32_t                   gpl_compatible:1;     /*    84: 0=
  4 */
> > >>
> > >>         /* XXX 31 bits hole, try to pack */
> > >
> > > How come the uint64_t below is 8-byte aligned, not 2-byte aligned?
> > > Does strace use a special definition of uint64_t?
> >
> > I guess this is because of the netns_dev field definition in struct
> > bpf_prog_info_struct at bpf_attr.h:
> >
> > struct bpf_prog_info_struct {
> >        ...
> >         uint32_t gpl_compatible:1;
> >         /*
> >          * The kernel UAPI is broken by Linux commit
> >          * v4.16-rc1~123^2~227^2~5^2~2 .
> >          */
> >         uint64_t ATTRIBUTE_ALIGNED(8) netns_dev; /* skip check */
>=20
> Oh, the bug was even documented, with its cause ;-)
> That's commit 675fc275a3a2d905 ("bpf: offload: report device information
> for offloaded programs").
>=20
> Partially fixed by commit 36f9814a494a874d ("bpf: fix uapi hole for 32 bit
> compat applications"), which left architectures with 16-bit alignment
> broken...

The offending commit seems to be the merge commit v4.18-rc1~114
that replaced "__u32 :32;" from the fix commit v4.17~4^2^2 with
"__u32 gpl_compatible:1;" from earlier commit v4.18-rc1~114^2~376^2~6.

> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
> --=20
> Strace-devel mailing list
> Strace-devel@lists.strace.io
> https://lists.strace.io/mailman/listinfo/strace-devel

--=20
ldv

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJc5HT0AAoJEAVFT+BVnCUINtkP/iwlTPFlVmPZKcgxBIYCGNex
N8KP4n0oZka7ps9p7xwpuYiIoQzLdW6S+b2qiDPQbj56lDDaijpyFo8qlPoL0l2+
bvE4ve6XulyDVvhwpVGK987OSHE2vGf9ljbD1rP8GM+6Gyj5/eNTV/N+39a3PYKa
tiBzcobPFlNemroFLkwDsaMQQ3+P47mULVnQxn7vw4MB/hgOJBu2v+Yw7tnHLTGL
aRwCqxzJYmmFQLNyaCi4t3UmUxYL+SNnzIy4rGlqhiSV2uHfzPAr3WyH0FnwdHcX
jfOasJTznddPuyu9Pbd+5XTxrIK7r1K65Zrdt2PhtlF/aJmHgBMF+BG3idt53i21
bMmGh03h4k28IPJcgyPdl6T4zBSdN48Cqj6Kj3g4vWJnHmpBEiJFRORDHvgyDzW5
AyCY/IgfOiPYFe5q1/lnj9XBUJfylxrAbjDopPoIC7VKTW32ndOXJLbFYPcjPCw/
n3GIg+TAfPiEB/+a9o2sPLpYgPfGWcV31TS8SWxb+e8qrZOjQdCOVbuXvXRNsUTF
qKC03jssOFZnjtjKIcy2BVxniF2eChSihI02qYBITCR84jm0WIPg1lcOKcBk3g5s
tz69PSKQNTgfuCU6K8yUb3Bk6bcRUpBIf2slrUHlGVW8zCOs6fqLvFHtkpPxmKJy
ehPKOhfqxDloy9KUhMW0
=sZYL
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
