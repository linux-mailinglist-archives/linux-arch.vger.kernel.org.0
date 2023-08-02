Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663FB76C960
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 11:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjHBJV6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 05:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjHBJVz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 05:21:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49060AC;
        Wed,  2 Aug 2023 02:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B10CD618BF;
        Wed,  2 Aug 2023 09:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249FEC433C8;
        Wed,  2 Aug 2023 09:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690968112;
        bh=J2tG/ScQRlNnbtP1aLVjnAnya21Uxa58M8ute6dFW0c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a0SxWMrQPIaK7W+vyl8W74wM/RpUfkJYTI89L0qS0ZML7dpEglRtG5r+jcxC1IT2e
         Z+fEknXE4N0Ip+NFG8Qly4pBAHpAlhJ6R2j48D9MjdcD43qrSWgNNn7nM6kGqZ1/zS
         yNyB4NH7rRIo6BSWKP2Vud3xznCRi3WhspWPVAsDYasVkqLtXKugQToGQahuVIaq+M
         tHuiuIlsX1U85iahLWnXmSiCLnvepittiz3axvYsvqFiiFhDDTvfxxo/kYNTguwus3
         wpN1WPf0b3A64En2R534kwhsysetABQ47XPJW1SLQLThyVQQXoQKcv7hvvOdT6hCby
         efjqgYxjs2keQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6b9e478e122so5787814a34.1;
        Wed, 02 Aug 2023 02:21:52 -0700 (PDT)
X-Gm-Message-State: ABy/qLZI3KvFmJc5bfMzFrpSOnRwNdtiDvR1jkxSQJe/7imEayZTmEyf
        YoHJgBi0/OdZYtpxHuC4KTU312lTJVpXcxEAUpg=
X-Google-Smtp-Source: APBJJlH3c324ht1eos/YhELsl6hmz9tCdWDPwW3/3TMSZ1rYLOZtuFOITsxrCpyDvWQqeVRKE0+zOSsUjG3zFVlE0yg=
X-Received: by 2002:a05:6870:9107:b0:1bb:7f9f:2fc5 with SMTP id
 o7-20020a056870910700b001bb7f9f2fc5mr17842152oae.17.1690968111305; Wed, 02
 Aug 2023 02:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220109181529.351420-1-masahiroy@kernel.org> <20220109181529.351420-3-masahiroy@kernel.org>
 <YdwZe9DHJZUaa6aO@buildd.core.avm.de> <20230623144544.GA24871@lxhi-065>
 <20230719190902.GA11207@lxhi-064.domain> <CAK7LNAQhn28Wbb97+U_3n0EwoKnonjFoY3OnKcE7aqnSgRc4ow@mail.gmail.com>
 <20230725092433.GA57787@lxhi-064.domain>
In-Reply-To: <20230725092433.GA57787@lxhi-064.domain>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 2 Aug 2023 18:21:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR4rJwrT2KLjLw-AbBvhO38xCZigC9C+DUVkn_5JM-KyQ@mail.gmail.com>
Message-ID: <CAK7LNAR4rJwrT2KLjLw-AbBvhO38xCZigC9C+DUVkn_5JM-KyQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] kbuild: rename cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Nicolas Schier <n.schier@avm.de>,
        SzuWei Lin <szuweilin@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Matthias.Thomae@de.bosch.com,
        yyankovskyi@de.adit-jv.com, Dirk.Behme@de.bosch.com,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009b1ced0601ed3171"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--0000000000009b1ced0601ed3171
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 6:24=E2=80=AFPM Eugeniu Rosca <erosca@de.adit-jv.co=
m> wrote:
>
> Hello Yamada-san,
>
> Appreciate your willingness to support. Some findings below.
>
> On Sun, Jul 23, 2023 at 01:08:46AM +0900, Masahiro Yamada wrote:
> > On Thu, Jul 20, 2023 at 4:09=E2=80=AFAM Eugeniu Rosca <erosca@de.adit-j=
v.com> wrote:
> > > On Fri, Jun 23, 2023 at 04:45:44PM +0200, Eugeniu Rosca wrote:
>
> [..]
>
> > > > I will continue to increase my understanding behind what's happenin=
g.
> > > > In case there are already any suggestions, would appreciate those.
> > >
> > > JFYI, we've got confirmation from Qualcomm Customer Support interface
> > > that reverting [1] heals the issue on QC end as well. However, it loo=
ks
> > > like none of us has clear understanding how to properly
> > > troubleshoot/trace/compare the behavior before and after the commit.
> > >
> > > I would happily follow any suggestions.
> > >
> > > > [1] https://android.googlesource.com/kernel/common/+/bc6d3d83539512
> > > >     ("UPSTREAM: kbuild: rename cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd2=
2}")
> > > >
> > > > [2] https://lore.kernel.org/linux-kbuild/20230616194505.GA27753@lxh=
i-065/
>
> [..]
>
> > Please backport 64d8aaa4ef388b22372de4dc9ce3b9b3e5f45b6c
> > and see if the problem goes away.
>
> Unfortunately, the problem remains after backporting the above commit.
>
> After some more bisecting and some more trial-and-error, I finally came
> up with a reproduction scenario against vanilla. It also shows that
> after reverting 7ce7e984ab2b21 ("kbuild: rename
> cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}"), the problem goes away.
>
> It takes <30 seconds to reproduce the issue on my machine (on 2nd run).
>
> In order to make the test self-sufficient, it also clones the Linux
> sources (only during 1st run, with --depth 1, for minimal footprint),
> hence ~1.8 GB free space is required in /tmp .
>
> The repro.sh script:
>  =3D> https://gist.github.com/erosca/1372fdc24126dc98031444613450c494
>
> Output against vanilla on 1st run (always OK, matches real-life case):
>  =3D> https://gist.github.com/erosca/0f5b8e0a00a256d80f0c8a6364d81568
>
> Output against vanilla on 2nd/Nth run (NOK: Argument list too long):
>  =3D> https://gist.github.com/erosca/e5c2c6479cc32244cc38d308deea4cf5
>
> Output against vanilla + revert_of_7ce7e984ab2b2 on Nth run (always OK):
>  =3D> https://gist.github.com/erosca/57e114f92ea20132e19fc7f5a46e7c65
>
> Would it be possible to get your thoughts on the above?
>
> --
> Best regards,
> Eugeniu Rosca





Indeed, reverting 7ce7e984ab2b218d6e92d5165629022fe2daf9ee
makes qcom's external module build successfully
(but rebuilding is super slow).

Interestingly, revert 7ce7e984ab2b218d6e92d5165629022fe2daf9ee
then apply the attached patch, then
'Argument list too long' will come back.

So, this is unrelated to the actual build commands.




I suspect bare 'export', which expands all variables
while apparently most of them are not meant exported.



Insert the following in your reproducer, then it will work.


# qcom's audio-kernel sprinkles 'export' everywhere.
# Remove bare use of 'export'
find "$ABS_KMOD" -name Kbuild | xargs sed -i '/export$/d'




--
Best Regards
Masahiro Yamada

--0000000000009b1ced0601ed3171
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Add-dummy-commands-to-make-qcom-s-external-module-fa.patch"
Content-Disposition: attachment; 
	filename="0001-Add-dummy-commands-to-make-qcom-s-external-module-fa.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lktimmix0>
X-Attachment-Id: f_lktimmix0

RnJvbSBhMWQ2NDEyMzg4NTFkYmRlMDBhMzdiN2IyMDNiMTEwZTc4NmVkZDFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBXZWQsIDIgQXVnIDIwMjMgMTg6MTE6MzIgKzA5MDAKU3ViamVjdDogW1BBVENIXSBB
ZGQgZHVtbXkgY29tbWFuZHMgdG8gbWFrZSBxY29tJ3MgZXh0ZXJuYWwgbW9kdWxlIGZhaWwKClJl
dmVydCA3Y2U3ZTk4NGFiMmIyMThkNmU5MmQ1MTY1NjI5MDIyZmUyZGFmOWVlIGFuZAphcHBseSB0
aGlzIGluc3RlYWQuCgpJIHNlZQoKL2Jpbi9zaDogQXJndW1lbnQgbGlzdCB0b28gbG9uZwoKU2ln
bmVkLW9mZi1ieTogTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4KLS0tCiBz
Y3JpcHRzL01ha2VmaWxlLmxpYiB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zY3JpcHRz
L01ha2VmaWxlLmxpYiBiL3NjcmlwdHMvTWFrZWZpbGUubGliCmluZGV4IDIyNzBlZDgxOWEyOS4u
YzQ4MTAxOGQxYjVmIDEwMDY0NAotLS0gYS9zY3JpcHRzL01ha2VmaWxlLmxpYgorKysgYi9zY3Jp
cHRzL01ha2VmaWxlLmxpYgpAQCAtNTU5LDMgKzU1OSwzNiBAQCBkZWZpbmUgZmlsZWNoa19vZmZz
ZXRzCiAJIGVjaG8gIiI7IFwKIAkgZWNobyAiI2VuZGlmIgogZW5kZWYKKworCisjIFRoZXNlIGR1
bW15IGNvbW1hbmRzIGFyZSBub3QgdXNlZCBhbnl3aGVyZSwgYnV0CisjIG1ha2UgcWNvbSdzIGV4
dGVybmFsIG1vZHVsZSBmYWlsIHRvIGJ1aWxkLgorIyBxY29tJ3MgTWFrZWZpbGUgdXNlIGJhcmUg
J2V4cG9ydCcuCisjIEhhdmluZyBtb3JlIGFuZCBtb3JlIHNoZWxsIGNvbW1hbmRzIG1heSBmbG9v
ZCB2YXJpYWJsZSBleHBhbnNpb25zLgorCitxdWlldF9jbWRfZHVtbXkxID0gRk9PICAgICRACisg
ICAgICBjbWRfZHVtbXkxID0gY2F0ICQocmVhbC1wcmVyZXFzKSA+ICRACisKK3F1aWV0X2NtZF9k
dW1teTIgPSBGT08gICAgJEAKKyAgICAgIGNtZF9kdW1teTIgPSBjYXQgJChyZWFsLXByZXJlcXMp
ID4gJEAKKworcXVpZXRfY21kX2R1bW15MyA9IEZPTyAgICAkQAorICAgICAgY21kX2R1bW15MyA9
IGNhdCAkKHJlYWwtcHJlcmVxcykgPiAkQAorCitxdWlldF9jbWRfZHVtbXk0ID0gRk9PICAgICRA
CisgICAgICBjbWRfZHVtbXk0ID0gY2F0ICQocmVhbC1wcmVyZXFzKSA+ICRACisKK3F1aWV0X2Nt
ZF9kdW1teTUgPSBGT08gICAgJEAKKyAgICAgIGNtZF9kdW1teTUgPSBjYXQgJChyZWFsLXByZXJl
cXMpID4gJEAKKworcXVpZXRfY21kX2R1bW15NiA9IEZPTyAgICAkQAorICAgICAgY21kX2R1bW15
NiA9IGNhdCAkKHJlYWwtcHJlcmVxcykgPiAkQAorCitxdWlldF9jbWRfZHVtbXk3ID0gRk9PICAg
ICRACisgICAgICBjbWRfZHVtbXk3ID0gY2F0ICQocmVhbC1wcmVyZXFzKSA+ICRACisKK3F1aWV0
X2NtZF9kdW1teTggPSBGT08gICAgJEAKKyAgICAgIGNtZF9kdW1teTggPSBjYXQgJChyZWFsLXBy
ZXJlcXMpID4gJEAKKworcXVpZXRfY21kX2R1bW15OSA9IEZPTyAgICAkQAorICAgICAgY21kX2R1
bW15OSA9IGNhdCAkKHJlYWwtcHJlcmVxcykgPiAkQAotLSAKMi4zOS4yCgo=
--0000000000009b1ced0601ed3171--
