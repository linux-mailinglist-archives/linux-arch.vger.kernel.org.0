Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDA6D6036
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 14:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjDDMZO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 08:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjDDMYx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 08:24:53 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B5A90;
        Tue,  4 Apr 2023 05:24:51 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bi39so2135791qkb.13;
        Tue, 04 Apr 2023 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680611091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv6dGXazdk0fPECPtfqTnYk8+03xVSm7eCN2KSmwy8g=;
        b=TgnVgVKqI2CopiCXBTlxZ9lpsr5X+TNGRGMzQdVS1liqAZw4LvDLPAzFv4wFK78BFW
         /2a30wN26cVMWBtXw2Ie8TAte8Frd/SWo4S7RRmQZYzHIWKXYqz0K3DnXQIMK4MG1Hkv
         ds6EO6kC1gsCQ/wFBDneTqfm0Sn57k3g+KEkI7jaYV0b9L6LyzMwtdeDSKEMWWw4uk5I
         alGbbzgnCOY583BdrX6HA4hJQigSu9WpBlu/q0tKaGkocE+e4bX8iJppuLA0mT8lCz9v
         u7p3HN5rjgOTIDTifw8V3Qh0iKOSf8qelMGQDxZOlRpwRg8zXvElE9oWUUXv+AVNZkje
         jDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yv6dGXazdk0fPECPtfqTnYk8+03xVSm7eCN2KSmwy8g=;
        b=1sc4CDmv2UzkwSqXm/gtGhngh8ZidCqy7u0a8cznLQQkmytV8COQp0TeQKK1x7BqAp
         HpLTh+BMiw4IfpK6nUPtkk7GOy6O9N19UOsC7un2gbGXEjcf2ybCZvSm8VRyBzqR0x7r
         POIfWnSeEfiKzzb8lRO+ZJR+uVUv/IdzjAlGdNOzoytlEAqacksNtq1v2Mg/GAXAEsl4
         1veeN8KkxBQhpoFqHei1u+yBYjdT1xkE33PPS6dVMgBqCKUgL20NwFqKIxbNQeyKFlOz
         yWdXKcn2qmpXyhIZJUThXv+I4b/mkEXp7z1UQbCDCZxBkXc+ejzeg2F+dA2kSVGOqG2o
         AQKA==
X-Gm-Message-State: AAQBX9c+GHe3ZnV/ZIDpvqDEjfy81lgtEpisAd5ahALmRAYANvcFXZBV
        dTNk0+rWhfm2nxacuByU5DgyPCeJ7kXClE9+lCE=
X-Google-Smtp-Source: AKy350aiVbMhHiGRKnFfb2o4V5k4kORRlGAY8vwxuqMcERXOV4a6D2IXcHOYATH0YHLG3/s0FrZIr5VkqDPPFqxOSfU=
X-Received: by 2002:a05:620a:280a:b0:74a:3ca4:a121 with SMTP id
 f10-20020a05620a280a00b0074a3ca4a121mr974178qkp.6.1680611090718; Tue, 04 Apr
 2023 05:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230305205628.27385-1-ubizjak@gmail.com> <20230305205628.27385-2-ubizjak@gmail.com>
 <ZB2v+avNt52ac/+w@FVFF77S0Q05N> <CAFULd4ZCgxDYnyy--qdgKoAo_y7MbNSaQdbdBFefnFuMoM2OYw@mail.gmail.com>
 <ZB3MR8lGbnea9ui6@FVFF77S0Q05N> <ZB3QtDYuWdpiD5qk@FVFF77S0Q05N>
 <CAFULd4aFUF5k=QJD8tDp4qzm2iBF7=rNvp1SJWrg44X5hTFxtQ@mail.gmail.com> <ZCqoRNU8EJhKJVEu@FVFF77S0Q05N>
In-Reply-To: <ZCqoRNU8EJhKJVEu@FVFF77S0Q05N>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 4 Apr 2023 14:24:38 +0200
Message-ID: <CAFULd4ZUnbtDYXBBbuTJnq9wLSf5cZTc=hUPxg6-8KRNA7YVeQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] locking/atomic: Add missing cast to try_cmpxchg() fallbacks
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000011a71705f881c3d7"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--00000000000011a71705f881c3d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 3, 2023 at 12:19=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Sun, Mar 26, 2023 at 09:28:38PM +0200, Uros Bizjak wrote:
> > On Fri, Mar 24, 2023 at 5:33=E2=80=AFPM Mark Rutland <mark.rutland@arm.=
com> wrote:
> > >
> > > On Fri, Mar 24, 2023 at 04:14:22PM +0000, Mark Rutland wrote:
> > > > On Fri, Mar 24, 2023 at 04:43:32PM +0100, Uros Bizjak wrote:
> > > > > On Fri, Mar 24, 2023 at 3:13=E2=80=AFPM Mark Rutland <mark.rutlan=
d@arm.com> wrote:
> > > > > >
> > > > > > On Sun, Mar 05, 2023 at 09:56:19PM +0100, Uros Bizjak wrote:
> > > > > > > Cast _oldp to the type of _ptr to avoid incompatible-pointer-=
types warning.
> > > > > >
> > > > > > Can you give an example of where we are passing an incompatible=
 pointer?
> > > > >
> > > > > An example is patch 10/10 from the series, which will fail withou=
t
> > > > > this fix when fallback code is used. We have:
> > > > >
> > > > > -       } while (local_cmpxchg(&rb->head, offset, head) !=3D offs=
et);
> > > > > +       } while (!local_try_cmpxchg(&rb->head, &offset, head));
> > > > >
> > > > > where rb->head is defined as:
> > > > >
> > > > > typedef struct {
> > > > >    atomic_long_t a;
> > > > > } local_t;
> > > > >
> > > > > while offset is defined as 'unsigned long'.
> > > >
> > > > Ok, but that's because we're doing the wrong thing to start with.
> > > >
> > > > Since local_t is defined in terms of atomic_long_t, we should defin=
e the
> > > > generic local_try_cmpxchg() in terms of atomic_long_try_cmpxchg(). =
We'll still
> > > > have a mismatch between 'long *' and 'unsigned long *', but then we=
 can fix
> > > > that in the callsite:
> > > >
> > > >       while (!local_try_cmpxchg(&rb->head, &(long *)offset, head))
> > >
> > > Sorry, that should be:
> > >
> > >         while (!local_try_cmpxchg(&rb->head, (long *)&offset, head))
> >
> > The fallbacks are a bit more complicated than above, and are different
> > from atomic_try_cmpxchg.
> >
> > Please note in patch 2/10, the falbacks when arch_try_cmpxchg_local
> > are not defined call arch_cmpxchg_local. Also in patch 2/10,
> > try_cmpxchg_local is introduced, where it calls
> > arch_try_cmpxchg_local. Targets (and generic code) simply define (e.g.
> > :
> >
> > #define local_cmpxchg(l, o, n) \
> >        (cmpxchg_local(&((l)->a.counter), (o), (n)))
> > +#define local_try_cmpxchg(l, po, n) \
> > +       (try_cmpxchg_local(&((l)->a.counter), (po), (n)))
> >
> > which is part of the local_t API. Targets should either define all
> > these #defines, or none. There are no partial fallbacks as is the case
> > with atomic_t.
>
> Whether or not there are fallbacks is immaterial.
>
> In those cases, architectures can just as easily write C wrappers, e.g.
>
> long local_cmpxchg(local_t *l, long old, long new)
> {
>         return cmpxchg_local(&l->a.counter, old, new);
> }
>
> long local_try_cmpxchg(local_t *l, long *old, long new)
> {
>         return try_cmpxchg_local(&l->a.counter, old, new);
> }

Please find attached the complete prototype patch that implements the
above suggestion.

The patch includes:
- implementation of instrumented try_cmpxchg{,64}_local definitions
- corresponding arch_try_cmpxchg{,64}_local fallback definitions
- generic local{,64}_try_cmpxchg (and local{,64}_cmpxchg) C wrappers

- x86 specific local_try_cmpxchg (and local_cmpxchg) C wrappers
- x86 specific arch_try_cmpxchg_local definition

- kernel/events/ring_buffer.c change to test local_try_cmpxchg
implementation and illustrate the transition
- arch/x86/events/core.c change to test local64_try_cmpxchg
implementation and illustrate the transition

The definition of atomic_long_t is different for 64-bit and 32-bit
targets (s64 vs int), so target specific C wrappers have to use
different casts to account for this difference.

Uros.

--00000000000011a71705f881c3d7
Content-Type: text/plain; charset="US-ASCII"; name="try_cmpxchg_local-04042023.diff.txt"
Content-Disposition: attachment; 
	filename="try_cmpxchg_local-04042023.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lg28ey5r0>
X-Attachment-Id: f_lg28ey5r0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2V2ZW50cy9jb3JlLmMgYi9hcmNoL3g4Ni9ldmVudHMvY29y
ZS5jCmluZGV4IGQwOTZiMDRiZjgwZS4uZDkzMTBlOTM2M2YxIDEwMDY0NAotLS0gYS9hcmNoL3g4
Ni9ldmVudHMvY29yZS5jCisrKyBiL2FyY2gveDg2L2V2ZW50cy9jb3JlLmMKQEAgLTEyOSwxMyAr
MTI5LDEyIEBAIHU2NCB4ODZfcGVyZl9ldmVudF91cGRhdGUoc3RydWN0IHBlcmZfZXZlbnQgKmV2
ZW50KQogCSAqIGV4Y2hhbmdlIGEgbmV3IHJhdyBjb3VudCAtIHRoZW4gYWRkIHRoYXQgbmV3LXBy
ZXYgZGVsdGEKIAkgKiBjb3VudCB0byB0aGUgZ2VuZXJpYyBldmVudCBhdG9taWNhbGx5OgogCSAq
LwotYWdhaW46CiAJcHJldl9yYXdfY291bnQgPSBsb2NhbDY0X3JlYWQoJmh3Yy0+cHJldl9jb3Vu
dCk7Ci0JcmRwbWNsKGh3Yy0+ZXZlbnRfYmFzZV9yZHBtYywgbmV3X3Jhd19jb3VudCk7CiAKLQlp
ZiAobG9jYWw2NF9jbXB4Y2hnKCZod2MtPnByZXZfY291bnQsIHByZXZfcmF3X2NvdW50LAotCQkJ
CQluZXdfcmF3X2NvdW50KSAhPSBwcmV2X3Jhd19jb3VudCkKLQkJZ290byBhZ2FpbjsKKwlkbyB7
CisJCXJkcG1jbChod2MtPmV2ZW50X2Jhc2VfcmRwbWMsIG5ld19yYXdfY291bnQpOworCX0gd2hp
bGUgKCFsb2NhbDY0X3RyeV9jbXB4Y2hnKCZod2MtPnByZXZfY291bnQsICZwcmV2X3Jhd19jb3Vu
dCwKKwkJCQkgICAgICBuZXdfcmF3X2NvdW50KSk7CiAKIAkvKgogCSAqIE5vdyB3ZSBoYXZlIHRo
ZSBuZXcgcmF3IHZhbHVlIGFuZCBoYXZlIHVwZGF0ZWQgdGhlIHByZXYKZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2NtcHhjaGcuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NtcHhj
aGcuaAppbmRleCA5NGZiZTZhZTc0MzEuLjU0MDU3M2Y1MTViNyAxMDA2NDQKLS0tIGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vY21weGNoZy5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NtcHhj
aGcuaApAQCAtMjIxLDkgKzIyMSwxNSBAQCBleHRlcm4gdm9pZCBfX2FkZF93cm9uZ19zaXplKHZv
aWQpCiAjZGVmaW5lIF9fdHJ5X2NtcHhjaGcocHRyLCBwb2xkLCBuZXcsIHNpemUpCQkJCVwKIAlf
X3Jhd190cnlfY21weGNoZygocHRyKSwgKHBvbGQpLCAobmV3KSwgKHNpemUpLCBMT0NLX1BSRUZJ
WCkKIAorI2RlZmluZSBfX3RyeV9jbXB4Y2hnX2xvY2FsKHB0ciwgcG9sZCwgbmV3LCBzaXplKQkJ
CVwKKwlfX3Jhd190cnlfY21weGNoZygocHRyKSwgKHBvbGQpLCAobmV3KSwgKHNpemUpLCAiIikK
KwogI2RlZmluZSBhcmNoX3RyeV9jbXB4Y2hnKHB0ciwgcG9sZCwgbmV3KSAJCQkJXAogCV9fdHJ5
X2NtcHhjaGcoKHB0ciksIChwb2xkKSwgKG5ldyksIHNpemVvZigqKHB0cikpKQogCisjZGVmaW5l
IGFyY2hfdHJ5X2NtcHhjaGdfbG9jYWwocHRyLCBwb2xkLCBuZXcpCQkJCVwKKwlfX3RyeV9jbXB4
Y2hnX2xvY2FsKChwdHIpLCAocG9sZCksIChuZXcpLCBzaXplb2YoKihwdHIpKSkKKwogLyoKICAq
IHhhZGQoKSBhZGRzICJpbmMiIHRvICIqcHRyIiBhbmQgYXRvbWljYWxseSByZXR1cm5zIHRoZSBw
cmV2aW91cwogICogdmFsdWUgb2YgIipwdHIiLgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vbG9jYWwuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2xvY2FsLmgKaW5kZXggMzQ5YTQ3
YWNhYTRhLi5kMjg2YTZjN2MwYjcgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2xv
Y2FsLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbG9jYWwuaApAQCAtMTIwLDggKzEyMCwy
MCBAQCBzdGF0aWMgaW5saW5lIGxvbmcgbG9jYWxfc3ViX3JldHVybihsb25nIGksIGxvY2FsX3Qg
KmwpCiAjZGVmaW5lIGxvY2FsX2luY19yZXR1cm4obCkgIChsb2NhbF9hZGRfcmV0dXJuKDEsIGwp
KQogI2RlZmluZSBsb2NhbF9kZWNfcmV0dXJuKGwpICAobG9jYWxfc3ViX3JldHVybigxLCBsKSkK
IAotI2RlZmluZSBsb2NhbF9jbXB4Y2hnKGwsIG8sIG4pIFwKLQkoY21weGNoZ19sb2NhbCgmKChs
KS0+YS5jb3VudGVyKSwgKG8pLCAobikpKQorc3RhdGljIGlubGluZSBsb25nIGxvY2FsX2NtcHhj
aGcobG9jYWxfdCAqbCwgbG9uZyBvbGQsIGxvbmcgbmV3KQoreworCXJldHVybiBjbXB4Y2hnX2xv
Y2FsKCZsLT5hLmNvdW50ZXIsIG9sZCwgbmV3KTsKK30KKworc3RhdGljIGlubGluZSBib29sIGxv
Y2FsX3RyeV9jbXB4Y2hnKGxvY2FsX3QgKmwsIGxvbmcgKm9sZCwgbG9uZyBuZXcpCit7CisjaWZk
ZWYgQ09ORklHXzY0QklUCisJcmV0dXJuIHRyeV9jbXB4Y2hnX2xvY2FsKCZsLT5hLmNvdW50ZXIs
IChzNjQgKilvbGQsIG5ldyk7CisjZWxzZQorCXJldHVybiB0cnlfY21weGNoZ19sb2NhbCgmbC0+
YS5jb3VudGVyLCAoaW50ICopb2xkLCBuZXcpOworI2VuZGlmCit9CisKIC8qIEFsd2F5cyBoYXMg
YSBsb2NrIHByZWZpeCAqLwogI2RlZmluZSBsb2NhbF94Y2hnKGwsIG4pICh4Y2hnKCYoKGwpLT5h
LmNvdW50ZXIpLCAobikpKQogCmRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1nZW5lcmljL2xvY2Fs
LmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL2xvY2FsLmgKaW5kZXggZmNhN2YxZDg0ODE4Li43Zjk3
MDE4ZGY2NmYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvbG9jYWwuaAorKysgYi9p
bmNsdWRlL2FzbS1nZW5lcmljL2xvY2FsLmgKQEAgLTQyLDYgKzQyLDcgQEAgdHlwZWRlZiBzdHJ1
Y3QKICNkZWZpbmUgbG9jYWxfaW5jX3JldHVybihsKSBhdG9taWNfbG9uZ19pbmNfcmV0dXJuKCYo
bCktPmEpCiAKICNkZWZpbmUgbG9jYWxfY21weGNoZyhsLCBvLCBuKSBhdG9taWNfbG9uZ19jbXB4
Y2hnKCgmKGwpLT5hKSwgKG8pLCAobikpCisjZGVmaW5lIGxvY2FsX3RyeV9jbXB4Y2hnKGwsIHBv
LCBuKSBhdG9taWNfbG9uZ190cnlfY21weGNoZygoJihsKS0+YSksIChwbyksIChuKSkKICNkZWZp
bmUgbG9jYWxfeGNoZyhsLCBuKSBhdG9taWNfbG9uZ194Y2hnKCgmKGwpLT5hKSwgKG4pKQogI2Rl
ZmluZSBsb2NhbF9hZGRfdW5sZXNzKGwsIF9hLCB1KSBhdG9taWNfbG9uZ19hZGRfdW5sZXNzKCgm
KGwpLT5hKSwgKF9hKSwgKHUpKQogI2RlZmluZSBsb2NhbF9pbmNfbm90X3plcm8obCkgYXRvbWlj
X2xvbmdfaW5jX25vdF96ZXJvKCYobCktPmEpCmRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1nZW5l
cmljL2xvY2FsNjQuaCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvbG9jYWw2NC5oCmluZGV4IDc2NWJl
MGI3ZDg4My4uMTQ5NjNhN2E2MjUzIDEwMDY0NAotLS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL2xv
Y2FsNjQuaAorKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL2xvY2FsNjQuaApAQCAtNDIsNyArNDIs
MTYgQEAgdHlwZWRlZiBzdHJ1Y3QgewogI2RlZmluZSBsb2NhbDY0X3N1Yl9yZXR1cm4oaSwgbCkg
bG9jYWxfc3ViX3JldHVybigoaSksICgmKGwpLT5hKSkKICNkZWZpbmUgbG9jYWw2NF9pbmNfcmV0
dXJuKGwpCWxvY2FsX2luY19yZXR1cm4oJihsKS0+YSkKIAotI2RlZmluZSBsb2NhbDY0X2NtcHhj
aGcobCwgbywgbikgbG9jYWxfY21weGNoZygoJihsKS0+YSksIChvKSwgKG4pKQorc3RhdGljIGlu
bGluZSBzNjQgbG9jYWw2NF9jbXB4Y2hnKGxvY2FsNjRfdCAqbCwgczY0IG9sZCwgczY0IG5ldykK
K3sKKwlyZXR1cm4gbG9jYWxfY21weGNoZygmbC0+YSwgb2xkLCBuZXcpOworfQorCitzdGF0aWMg
aW5saW5lIGJvb2wgbG9jYWw2NF90cnlfY21weGNoZyhsb2NhbDY0X3QgKmwsIHM2NCAqb2xkLCBz
NjQgbmV3KQoreworCXJldHVybiBsb2NhbF90cnlfY21weGNoZygmbC0+YSwgKGxvbmcgKilvbGQs
IG5ldyk7Cit9CisKICNkZWZpbmUgbG9jYWw2NF94Y2hnKGwsIG4pCWxvY2FsX3hjaGcoKCYobCkt
PmEpLCAobikpCiAjZGVmaW5lIGxvY2FsNjRfYWRkX3VubGVzcyhsLCBfYSwgdSkgbG9jYWxfYWRk
X3VubGVzcygoJihsKS0+YSksIChfYSksICh1KSkKICNkZWZpbmUgbG9jYWw2NF9pbmNfbm90X3pl
cm8obCkJbG9jYWxfaW5jX25vdF96ZXJvKCYobCktPmEpCkBAIC04MSw2ICs5MCw3IEBAIHR5cGVk
ZWYgc3RydWN0IHsKICNkZWZpbmUgbG9jYWw2NF9pbmNfcmV0dXJuKGwpCWF0b21pYzY0X2luY19y
ZXR1cm4oJihsKS0+YSkKIAogI2RlZmluZSBsb2NhbDY0X2NtcHhjaGcobCwgbywgbikgYXRvbWlj
NjRfY21weGNoZygoJihsKS0+YSksIChvKSwgKG4pKQorI2RlZmluZSBsb2NhbDY0X3RyeV9jbXB4
Y2hnKGwsIHBvLCBuKSBhdG9taWM2NF90cnlfY21weGNoZygoJihsKS0+YSksIChwbyksIChuKSkK
ICNkZWZpbmUgbG9jYWw2NF94Y2hnKGwsIG4pCWF0b21pYzY0X3hjaGcoKCYobCktPmEpLCAobikp
CiAjZGVmaW5lIGxvY2FsNjRfYWRkX3VubGVzcyhsLCBfYSwgdSkgYXRvbWljNjRfYWRkX3VubGVz
cygoJihsKS0+YSksIChfYSksICh1KSkKICNkZWZpbmUgbG9jYWw2NF9pbmNfbm90X3plcm8obCkJ
YXRvbWljNjRfaW5jX25vdF96ZXJvKCYobCktPmEpCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2F0b21pYy9hdG9taWMtYXJjaC1mYWxsYmFjay5oIGIvaW5jbHVkZS9saW51eC9hdG9taWMvYXRv
bWljLWFyY2gtZmFsbGJhY2suaAppbmRleCA3N2JjNTUyMmU2MWMuLjM2YzkyODUxY2RlZSAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9hdG9taWMvYXRvbWljLWFyY2gtZmFsbGJhY2suaAorKysg
Yi9pbmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMtYXJjaC1mYWxsYmFjay5oCkBAIC0yMTcsNiAr
MjE3LDI4IEBACiAKICNlbmRpZiAvKiBhcmNoX3RyeV9jbXB4Y2hnNjRfcmVsYXhlZCAqLwogCisj
aWZuZGVmIGFyY2hfdHJ5X2NtcHhjaGdfbG9jYWwKKyNkZWZpbmUgYXJjaF90cnlfY21weGNoZ19s
b2NhbChfcHRyLCBfb2xkcCwgX25ldykgXAorKHsgXAorCXR5cGVvZigqKF9wdHIpKSAqX19fb3Ag
PSAoX29sZHApLCBfX19vID0gKl9fX29wLCBfX19yOyBcCisJX19fciA9IGFyY2hfY21weGNoZ19s
b2NhbCgoX3B0ciksIF9fX28sIChfbmV3KSk7IFwKKwlpZiAodW5saWtlbHkoX19fciAhPSBfX19v
KSkgXAorCQkqX19fb3AgPSBfX19yOyBcCisJbGlrZWx5KF9fX3IgPT0gX19fbyk7IFwKK30pCisj
ZW5kaWYgLyogYXJjaF90cnlfY21weGNoZ19sb2NhbCAqLworCisjaWZuZGVmIGFyY2hfdHJ5X2Nt
cHhjaGc2NF9sb2NhbAorI2RlZmluZSBhcmNoX3RyeV9jbXB4Y2hnNjRfbG9jYWwoX3B0ciwgX29s
ZHAsIF9uZXcpIFwKKyh7IFwKKwl0eXBlb2YoKihfcHRyKSkgKl9fX29wID0gKF9vbGRwKSwgX19f
byA9ICpfX19vcCwgX19fcjsgXAorCV9fX3IgPSBhcmNoX2NtcHhjaGc2NF9sb2NhbCgoX3B0ciks
IF9fX28sIChfbmV3KSk7IFwKKwlpZiAodW5saWtlbHkoX19fciAhPSBfX19vKSkgXAorCQkqX19f
b3AgPSBfX19yOyBcCisJbGlrZWx5KF9fX3IgPT0gX19fbyk7IFwKK30pCisjZW5kaWYgLyogYXJj
aF90cnlfY21weGNoZzY0X2xvY2FsICovCisKICNpZm5kZWYgYXJjaF9hdG9taWNfcmVhZF9hY3F1
aXJlCiBzdGF0aWMgX19hbHdheXNfaW5saW5lIGludAogYXJjaF9hdG9taWNfcmVhZF9hY3F1aXJl
KGNvbnN0IGF0b21pY190ICp2KQpAQCAtMjQ1Niw0ICsyNDc4LDQgQEAgYXJjaF9hdG9taWM2NF9k
ZWNfaWZfcG9zaXRpdmUoYXRvbWljNjRfdCAqdikKICNlbmRpZgogCiAjZW5kaWYgLyogX0xJTlVY
X0FUT01JQ19GQUxMQkFDS19IICovCi0vLyBiNWU4N2JkZDVlZGU2MTQ3MGMyOWY3YTdlNGRlNzgx
YWYzNzcwZjA5CisvLyAxZjQ5YmQ0ODk1YTRiN2E1MzgzOTA2NjQ5MDI3MjA1YzUyZWM4MGFiCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMtaW5zdHJ1bWVudGVkLmggYi9p
bmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMtaW5zdHJ1bWVudGVkLmgKaW5kZXggN2ExMzllYzAz
MGIwLi4xNGE5MjEyY2M5ODcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvYXRvbWljL2F0b21p
Yy1pbnN0cnVtZW50ZWQuaAorKysgYi9pbmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMtaW5zdHJ1
bWVudGVkLmgKQEAgLTIwNjYsNiArMjA2NiwyNCBAQCBhdG9taWNfbG9uZ19kZWNfaWZfcG9zaXRp
dmUoYXRvbWljX2xvbmdfdCAqdikKIAlhcmNoX3N5bmNfY21weGNoZyhfX2FpX3B0ciwgX19WQV9B
UkdTX18pOyBcCiB9KQogCisjZGVmaW5lIHRyeV9jbXB4Y2hnX2xvY2FsKHB0ciwgb2xkcCwgLi4u
KSBcCisoeyBcCisJdHlwZW9mKHB0cikgX19haV9wdHIgPSAocHRyKTsgXAorCXR5cGVvZihvbGRw
KSBfX2FpX29sZHAgPSAob2xkcCk7IFwKKwlpbnN0cnVtZW50X2F0b21pY193cml0ZShfX2FpX3B0
ciwgc2l6ZW9mKCpfX2FpX3B0cikpOyBcCisJaW5zdHJ1bWVudF9hdG9taWNfd3JpdGUoX19haV9v
bGRwLCBzaXplb2YoKl9fYWlfb2xkcCkpOyBcCisJYXJjaF90cnlfY21weGNoZ19sb2NhbChfX2Fp
X3B0ciwgX19haV9vbGRwLCBfX1ZBX0FSR1NfXyk7IFwKK30pCisKKyNkZWZpbmUgdHJ5X2NtcHhj
aGc2NF9sb2NhbChwdHIsIG9sZHAsIC4uLikgXAorKHsgXAorCXR5cGVvZihwdHIpIF9fYWlfcHRy
ID0gKHB0cik7IFwKKwl0eXBlb2Yob2xkcCkgX19haV9vbGRwID0gKG9sZHApOyBcCisJaW5zdHJ1
bWVudF9hdG9taWNfd3JpdGUoX19haV9wdHIsIHNpemVvZigqX19haV9wdHIpKTsgXAorCWluc3Ry
dW1lbnRfYXRvbWljX3dyaXRlKF9fYWlfb2xkcCwgc2l6ZW9mKCpfX2FpX29sZHApKTsgXAorCWFy
Y2hfdHJ5X2NtcHhjaGc2NF9sb2NhbChfX2FpX3B0ciwgX19haV9vbGRwLCBfX1ZBX0FSR1NfXyk7
IFwKK30pCisKICNkZWZpbmUgY21weGNoZ19kb3VibGUocHRyLCAuLi4pIFwKICh7IFwKIAl0eXBl
b2YocHRyKSBfX2FpX3B0ciA9IChwdHIpOyBcCkBAIC0yMDgzLDQgKzIxMDEsNCBAQCBhdG9taWNf
bG9uZ19kZWNfaWZfcG9zaXRpdmUoYXRvbWljX2xvbmdfdCAqdikKIH0pCiAKICNlbmRpZiAvKiBf
TElOVVhfQVRPTUlDX0lOU1RSVU1FTlRFRF9IICovCi0vLyA3NjRmNzQxZWI3N2E3YWQ1NjVkYzhk
OTljZTI4MzdkNTU0MmU4YWVlCisvLyA0NTZlMjA2YzdlNGU2ODExMjZjNDgyZTRlZGNjNmY0Njky
MWFjNzMxCmRpZmYgLS1naXQgYS9rZXJuZWwvZXZlbnRzL3JpbmdfYnVmZmVyLmMgYi9rZXJuZWwv
ZXZlbnRzL3JpbmdfYnVmZmVyLmMKaW5kZXggMjczYTBmZTc5MTBhLi4xMTFhYjg1ZWU5N2QgMTAw
NjQ0Ci0tLSBhL2tlcm5lbC9ldmVudHMvcmluZ19idWZmZXIuYworKysgYi9rZXJuZWwvZXZlbnRz
L3JpbmdfYnVmZmVyLmMKQEAgLTE5MSw5ICsxOTEsMTAgQEAgX19wZXJmX291dHB1dF9iZWdpbihz
dHJ1Y3QgcGVyZl9vdXRwdXRfaGFuZGxlICpoYW5kbGUsCiAKIAlwZXJmX291dHB1dF9nZXRfaGFu
ZGxlKGhhbmRsZSk7CiAKKwlvZmZzZXQgPSBsb2NhbF9yZWFkKCZyYi0+aGVhZCk7CiAJZG8gewog
CQl0YWlsID0gUkVBRF9PTkNFKHJiLT51c2VyX3BhZ2UtPmRhdGFfdGFpbCk7Ci0JCW9mZnNldCA9
IGhlYWQgPSBsb2NhbF9yZWFkKCZyYi0+aGVhZCk7CisJCWhlYWQgPSBvZmZzZXQ7CiAJCWlmICgh
cmItPm92ZXJ3cml0ZSkgewogCQkJaWYgKHVubGlrZWx5KCFyaW5nX2J1ZmZlcl9oYXNfc3BhY2Uo
aGVhZCwgdGFpbCwKIAkJCQkJCQkgICAgcGVyZl9kYXRhX3NpemUocmIpLApAQCAtMjE3LDcgKzIx
OCw3IEBAIF9fcGVyZl9vdXRwdXRfYmVnaW4oc3RydWN0IHBlcmZfb3V0cHV0X2hhbmRsZSAqaGFu
ZGxlLAogCQkJaGVhZCArPSBzaXplOwogCQllbHNlCiAJCQloZWFkIC09IHNpemU7Ci0JfSB3aGls
ZSAobG9jYWxfY21weGNoZygmcmItPmhlYWQsIG9mZnNldCwgaGVhZCkgIT0gb2Zmc2V0KTsKKwl9
IHdoaWxlICghbG9jYWxfdHJ5X2NtcHhjaGcoJnJiLT5oZWFkLCAmb2Zmc2V0LCBoZWFkKSk7CiAK
IAlpZiAoYmFja3dhcmQpIHsKIAkJb2Zmc2V0ID0gaGVhZDsKZGlmZiAtLWdpdCBhL3NjcmlwdHMv
YXRvbWljL2dlbi1hdG9taWMtZmFsbGJhY2suc2ggYi9zY3JpcHRzL2F0b21pYy9nZW4tYXRvbWlj
LWZhbGxiYWNrLnNoCmluZGV4IDNhMDc2OTVlM2M4OS4uNmU4NTNmMGRhZDhkIDEwMDc1NQotLS0g
YS9zY3JpcHRzL2F0b21pYy9nZW4tYXRvbWljLWZhbGxiYWNrLnNoCisrKyBiL3NjcmlwdHMvYXRv
bWljL2dlbi1hdG9taWMtZmFsbGJhY2suc2gKQEAgLTIyNSw2ICsyMjUsMTAgQEAgZm9yIGNtcHhj
aGcgaW4gImNtcHhjaGciICJjbXB4Y2hnNjQiOyBkbwogCWdlbl90cnlfY21weGNoZ19mYWxsYmFj
a3MgIiR7Y21weGNoZ30iCiBkb25lCiAKK2ZvciBjbXB4Y2hnIGluICJjbXB4Y2hnX2xvY2FsIiAi
Y21weGNoZzY0X2xvY2FsIjsgZG8KKwlnZW5fdHJ5X2NtcHhjaGdfZmFsbGJhY2sgIiR7Y21weGNo
Z30iICIiCitkb25lCisKIGdyZXAgJ15bYS16XScgIiQxIiB8IHdoaWxlIHJlYWQgbmFtZSBtZXRh
IGFyZ3M7IGRvCiAJZ2VuX3Byb3RvICIke21ldGF9IiAiJHtuYW1lfSIgImF0b21pYyIgImludCIg
JHthcmdzfQogZG9uZQpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9hdG9taWMvZ2VuLWF0b21pYy1pbnN0
cnVtZW50ZWQuc2ggYi9zY3JpcHRzL2F0b21pYy9nZW4tYXRvbWljLWluc3RydW1lbnRlZC5zaApp
bmRleCA3N2MwNjUyNmE1NzQuLmM4MTY1ZTk0MzFiZiAxMDA3NTUKLS0tIGEvc2NyaXB0cy9hdG9t
aWMvZ2VuLWF0b21pYy1pbnN0cnVtZW50ZWQuc2gKKysrIGIvc2NyaXB0cy9hdG9taWMvZ2VuLWF0
b21pYy1pbnN0cnVtZW50ZWQuc2gKQEAgLTE3Myw3ICsxNzMsNyBAQCBmb3IgeGNoZyBpbiAieGNo
ZyIgImNtcHhjaGciICJjbXB4Y2hnNjQiICJ0cnlfY21weGNoZyIgInRyeV9jbXB4Y2hnNjQiOyBk
bwogCWRvbmUKIGRvbmUKIAotZm9yIHhjaGcgaW4gImNtcHhjaGdfbG9jYWwiICJjbXB4Y2hnNjRf
bG9jYWwiICJzeW5jX2NtcHhjaGciOyBkbworZm9yIHhjaGcgaW4gImNtcHhjaGdfbG9jYWwiICJj
bXB4Y2hnNjRfbG9jYWwiICJzeW5jX2NtcHhjaGciICJ0cnlfY21weGNoZ19sb2NhbCIgInRyeV9j
bXB4Y2hnNjRfbG9jYWwiIDsgZG8KIAlnZW5feGNoZyAiJHt4Y2hnfSIgIiIgIiIKIAlwcmludGYg
IlxuIgogZG9uZQo=
--00000000000011a71705f881c3d7--
