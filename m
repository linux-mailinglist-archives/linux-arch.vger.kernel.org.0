Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749125A0AE0
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 10:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiHYH7p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 03:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiHYH7n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 03:59:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F24CA3D41;
        Thu, 25 Aug 2022 00:59:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h24so23533085wrb.8;
        Thu, 25 Aug 2022 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=Vfkw9W/AhhJWI18QHChoanacLxrsAxoAtxB8f5v26BE=;
        b=O2eXpRu2eksOvhIXFf3UL7JQJjIYXYh7dzbr4CiRE90+a/ANnressQVxtGsO84tgh2
         MKDWvxee+YarW44C05RAkuydxWuJ78HoYrrkn5bx2JUAcyYQ0BTjQwGxGwxpp8nxdjQs
         NeEMSdv+kVpV9BsSQ4MhMdjhq9Uwz+lmoYvVR6otQz9aGsXeXrNZCqPmbL+6MWZL4IOX
         f9ijf/8PW477zjZI6oHjrhyaCZphuku+xLRyTPJbH33jL1pYNinoSrNlWDUe1GVELUoa
         ILkrlDOJ7P6eX0M7ndSHR/KWPU9MKomies8IpG2Z7m0RKPxjn19EPHzngIQbIkto/sJU
         RO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=Vfkw9W/AhhJWI18QHChoanacLxrsAxoAtxB8f5v26BE=;
        b=h5I++L6wqIUUD8JdR+OcTEBHt+Tk9AcJVvNKR/hgz84CaT10uBUc+c/DpEjo2aYNdf
         p6AdTqmS1vqaBKDFpy1tqcEFNmJlEpCqhGsAT588DKDObkGTww1QtDbPpsWU2U5D+r3q
         O10w32o8Uimu8vAwoO6qmASI7CNraPGshGaS/to/motVSPeyCSFWTgzV6S6dAosB5BTY
         VhyE6wu8WOTKipxrRP8iQ+cDKglOCprX1zNCjncLaMiZqMcXLSN10uIJC2un3h4HrM0y
         hFnEo2hgp++YW1M/9p8j1+O1LMtSA33wXfG432eGexBsbI8XawdxYtfS7faTE+Zb0+n3
         +3Fg==
X-Gm-Message-State: ACgBeo2jX/nUB4jT2iFWLxVZMN2pMsMLnoxhOt5WiK5Z06QF3GdxSpaM
        +SHOSXBeF7a7da6QTu7cQ3I=
X-Google-Smtp-Source: AA6agR7sBd1BeOS+iszBdkjwPm6hTbmMo0gsmEGbKv/cxJkuiuP9gF/7RnGkZpLYwnRHNcO0rYoJXQ==
X-Received: by 2002:a5d:5391:0:b0:225:55cc:84fd with SMTP id d17-20020a5d5391000000b0022555cc84fdmr1450969wrv.719.1661414380850;
        Thu, 25 Aug 2022 00:59:40 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id x11-20020a05600c2d0b00b003a5f3f5883dsm3993444wmf.17.2022.08.25.00.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:59:40 -0700 (PDT)
Message-ID: <ee51a03e-0cc7-06a6-2ae9-e68af02e891f@gmail.com>
Date:   Thu, 25 Aug 2022 09:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
 <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
 <CAHk-=wgSx8O0=p18C1aQuH4Gw7xmKujBKMEiSitCA7oG2h6WLg@mail.gmail.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <CAHk-=wgSx8O0=p18C1aQuH4Gw7xmKujBKMEiSitCA7oG2h6WLg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8EOuW8OYc0VexqmdxRQshbyB"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8EOuW8OYc0VexqmdxRQshbyB
Content-Type: multipart/mixed; boundary="------------CpwXMdjcL5eWQ3sq6aHwwBG0";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alex Colomar <alx@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-man <linux-man@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Zack Weinberg <zackw@panix.com>,
 LKML <linux-kernel@vger.kernel.org>, glibc <libc-alpha@sourceware.org>,
 GCC <gcc-patches@gcc.gnu.org>, bpf <bpf@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>, Linux API <linux-api@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 David Laight <David.Laight@aculab.com>,
 Joseph Myers <joseph@codesourcery.com>, Florian Weimer <fweimer@redhat.com>,
 Cyril Hrubis <chrubis@suse.cz>, David Howells <dhowells@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <ee51a03e-0cc7-06a6-2ae9-e68af02e891f@gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
 <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
 <CAHk-=wgSx8O0=p18C1aQuH4Gw7xmKujBKMEiSitCA7oG2h6WLg@mail.gmail.com>
In-Reply-To: <CAHk-=wgSx8O0=p18C1aQuH4Gw7xmKujBKMEiSitCA7oG2h6WLg@mail.gmail.com>

--------------CpwXMdjcL5eWQ3sq6aHwwBG0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTGludXMsDQoNCihPb3BzLCBJIG1pc3R5cGVkIHlvdSBuYW1lIGluIG15IHByZXZpb3Vz
IHJlcGx5OyBJJ20gb24gYSByb2xsIGZvciBmdW5ueSANCnR5cG9zIHRoaXMgd2VlayBpdCBz
ZWVtcykNCg0KT24gOC8yNS8yMiAwOTo0MiwgTGludXMgVG9ydmFsZHMgd3JvdGU6DQo+IE9u
IFRodSwgQXVnIDI1LCAyMDIyIGF0IDEyOjIwIEFNIEFsZWphbmRybyBDb2xvbWFyDQo+IDxh
bHgubWFucGFnZXNAZ21haWwuY29tPiB3cm90ZToNCj4+DQo+PiBUaGlzIHBhdGNoIGlzIG5v
dCBhYm91dCBrZXJuZWwsIGJ1dCBhYm91dCB0aGUgc2VjdGlvbiAyIGFuZCAzIG1hbnVhbA0K
Pj4gcGFnZXMsIHdoaWNoIGFyZSBkaXJlY3RlZCB0b3dhcmRzIHVzZXItc3BhY2UgcmVhZGVy
cyBtb3N0IG9mIHRoZSB0aW1lLg0KPiANCj4gVGhleSBhcmUgYWJvdXQgdGhlIHR5cGVzIHRv
IHRoZSBrZXJuZWwgaW50ZXJmYWNlcy4gVGhvc2UgdHlwZXMgdGhhdA0KPiB0aGUga2VybmVs
IGRlZmluZXMgYW5kIGV4cG9zZXMuDQo+IA0KPiBBbmQgdGhlIGtlcm5lbCB0eXBlIGluIHF1
ZXN0aW9uIGxvb2tzIGxpa2UgdGhpczoNCj4gDQo+ICAgICAgICAgIHN0cnVjdCB7IC8qIGFu
b255bW91cyBzdHJ1Y3QgdXNlZCBieSBCUEZfUFJPR19MT0FEIGNvbW1hbmQgKi8NCj4gICAg
ICAgICAgICAgICAgICBfX3UzMiAgICAgICAgICAgcHJvZ190eXBlOyAgICAgIC8qIG9uZSBv
ZiBlbnVtIGJwZl9wcm9nX3R5cGUgKi8NCj4gICAgICAgICAgICAgICAgICBfX3UzMiAgICAg
ICAgICAgaW5zbl9jbnQ7DQo+ICAgICAgICAgICAgICAgICAgX19hbGlnbmVkX3U2NCAgIGlu
c25zOw0KPiAgICAgICAgICAgICAgICAgIF9fYWxpZ25lZF91NjQgICBsaWNlbnNlOw0KPiAN
Cj4gYmVjYXVzZSB0aGUga2VybmVsIFVBUEkgaGVhZGVyIHdhbnRzIHRvDQo+IA0KPiAgIChh
KSB3b3JrIHdoZXRoZXIgb3Igbm90IDxzdGRpbnQuaD4gd2FzIGluY2x1ZGVkDQoNClRoZXNl
IGRheXMsIChhKSBpcyBtb3JlIG9mIGEgdGhlb3JldGljYWwgdGhpbmcsIHNpbmNlIHByb2dy
YW1zIGF2b2lkaW5nIA0KQzk5IDxzdGRpbnQuaD4gd2lsbCBoYXZlIGEgaGFyZCB0aW1lLg0K
DQo+IA0KPiAgIChiKSBkb2Vzbid0IHdhbnQgdG8gaW5jbHVkZSA8c3RkaW50Lmg+IHNvIGFz
IHRvIG5vdCBwb2xsdXRlIHRoZSBuYW1lc3BhY2UNCj4gDQo+ICAgKGMpIGFjdHVhbGx5IHdh
bnRzIHRvIHVzZSBvdXIgc3BlY2lhbCB0eXBlcw0KPiANCj4gSSBxdW90ZWQgYSBmZXcgbW9y
ZSBmaWVsZHMgZm9yIHRoYXQgKGMpIHJlYXNvbjogd2UndmUgaGFkIGEgbG9uZw0KPiBoaXN0
b3J5IG9mIGdldHRpbmcgdGhlIHVzZXIgc3BhY2UgQVBJIHdyb25nIGR1ZSB0byBzdHJhbmdl
IGFsaWdubWVudA0KPiBpc3N1ZXMsIHdoZXJlIDMyLWJpdCBhbmQgNjQtYml0IHRhcmdldHMg
aGFkIGRpZmZlcmVudCBhbGlnbm1lbnQgZm9yDQo+IHR5cGVzLiBTbyB0aGVuIHdlIGVuZGVk
IHVwIHdpdGggdmFyaW91cyBjb21wYXQgc3RydWN0dXJlcyB0byB0cmFuc2xhdGUNCj4gZnJv
bSBvbmUgdG8gdGhlIG90aGVyIGJlY2F1c2UgdGhleSBoYWQgYWxsIHRoZSBzYW1lIGZpZWxk
cywgYnV0DQo+IGRpZmZlcmVudCBwYWRkaW5nLg0KPiANCj4gVGhpcyBoYXBwZW5lZCBhIGZl
dyB0aW1lcyB3aXRoIHRoZSBEUk0gcGVvcGxlLCBhbmQgdGhleSBmaW5hbGx5IGdvdA0KPiB0
aXJlZCBvZiBpdCwgYW5kIHN0YXJ0ZWQgdXNpbmcgdGhhdCAiX19hbGlnbmVkX3U2NCIgdHlw
ZSwgd2hpY2ggaXMNCj4ganVzdCB0aGUgc2FtZSBvbGQgX191NjQsIGJ1dCBleHBsaWNpdGx5
IGFsaWduZWQgdG8gaXRzIG5hdHVyYWwNCj4gYWxpZ25tZW50Lg0KPiANCj4gU28gdGhlc2Ug
YXJlIHRoZSBtZW1iZXJzIHRoYXQgdGhlIGludGVyZmFjZSBhY3R1YWxseSB1c2VzLg0KPiAN
Cj4gSWYgeW91IGRvY3VtZW50IHRob3NlIG1lbWJlcnMsIHdvdWxkbid0IGl0IGJlIGdvb2Qg
dG8gaGF2ZSB0aGF0DQo+IGRvY3VtZW50YXRpb24gYmUgYWN0dWFsbHkgYWNjdXJhdGU/DQo+
IA0KPiBIb25lc3RseSwgSSBkb24ndCB0aGluayBpdCBtYWtlcyBhICpodWdlKiBhbW91bnQg
b2YgZGlmZmVyZW5jZSwgYnV0DQo+IGRvY3VtZW50YXRpb24gdGhhdCBkb2Vzbid0IGFjdHVh
bGx5IG1hdGNoIHRoZSBzb3VyY2Ugb2YgdGhlDQo+IGRvY3VtZW50YXRpb24gd2lsbCBqdXN0
IGNvbmZ1c2Ugc29tZWJvZHkgaW4gdGhlIGVuZC4gU29tZWJvZHkgd2lsbCBnbw0KPiAidGhh
dCdzIG5vdCByaWdodCIsIGFuZCBtYXliZSBldmVuIGNoYW5nZSB0aGUgc3RydWN0dXJlIGRl
ZmluaXRpb25zIHRvDQo+IG1hdGNoIHRoZSBkb2N1bWVudGF0aW9uLg0KPiANCj4gV2hpY2gg
d291bGQgYmUgd3JvbmcuDQo+IA0KPiBOb3csIHlvdSBkb24ndCBoYXZlIHRvIHRha2UgdGhl
IGtlcm5lbCB1YXBpIGhlYWRlcnMuIFdlICp0cnkqIHRvIG1ha2UNCj4gdGhvc2UgdXNhYmxl
IGFzLWlzLCBidXQgaGV5LCB0aGVyZSBoYXMgYmVlbiBwcm9ibGVtcyBpbiB0aGUgcGFzdCwg
YW5kDQo+IGl0J3Mgbm90IG5lY2Vzc2FyaWx5IHdyb25nIHRvIHRha2UgdGhlIGtlcm5lbCBo
ZWFkZXIgYW5kIHRoZW4gbXVuZ2UgaXQNCj4gdG8gYmUgImFwcHJvcHJpYXRlIiBmb3IgdXNl
ciBzcGFjZS4NCj4gDQo+IFNvIEkgZ3Vlc3MgeW91IGNhbiBqdXN0IG1ha2UgeW91ciBvd24g
c3RydWN0dXJlcyB3aXRoIHRoZSBuYW1lcyBhbmQNCj4gc3ludGF4IHlvdSB3YW50LCBhbmQg
c2F5ICJ0aGVzZSBhcmUgKm15KiBoZWFkZXIgZmlsZXMsIGFuZCAqbXkqDQo+IGRvY3VtZW50
YXRpb24gZm9yIHRoZW0iLg0KPiANCj4gVGhhdCdzIGZpbmUuIEJ1dCBJJ20gbm90IHN1cnBy
aXNlZCBpZiB0aGUga2VybmVsIG1haW50YWluZXIgdGhlbiBnb2VzDQo+ICJubywgdGhhdCdz
IG5vdCB0aGUgaW50ZXJmYWNlIEkgYWdyZWVkIHRvIiBpZiBvbmx5IGJlY2F1c2UgaXQncyBh
IHBhaW4NCj4gdG8gdmVyaWZ5IHRoYXQgeW91IGdvdCBpdCBhbGwgcmlnaHQuIE1heWJlIGl0
IHdhcyBhbGwgdHJpdmlhbCBhbmQNCj4gYXV0b21hdGVkIGFuZCB0aGVyZSBjYW4gYmUgbm8g
ZXJyb3JzLCBidXQgaXQncyBzdGlsbCBhICJ3aHkgaXMgdGhlcmUgYQ0KPiBkaWZmZXJlbnQg
Y29weSBvZiB0aGlzIGNvbXBsaWNhdGVkIGludGVyZmFjZSIuDQo+IA0KPiBJZiB5b3UgcmVh
bGx5IHdhbnQgdG8gZGVzY3JpYmUgdGhpbmdzIHRvIHBlb3BsZSwgd291bGRuJ3QgaXQgYmUg
bmljZXINCj4gdG8ganVzdCBzYXkgInRoZXJlJ3MgYSAzMi1iaXQgdW5zaWduZWQgJ3Byb2df
dHlwZScgbWVtYmVyIiBhbmQgbGVhdmUNCj4gaXQgYXQgdGhhdD8NCj4gDQo+IERvIHlvdSBy
ZWFsbHkgd2FudCB0byBlbmZvcmNlIHlvdXIgb3BpbmlvbiBvZiB3aGF0IGlzIHByZXR0aWVy
IG9uIHRoZQ0KPiBtYWludGFpbmVyIHRoYXQgd3JvdGUgdGhhdCB0aGluZywgYW5kIHRoZW4g
YXJndWUgd2l0aCBoaW0gd2hlbiBoZQ0KPiBkb2Vzbid0IGFncmVlPw0KDQpZb3UgY29udmlu
Y2VkIG1lLiAgVGhlIG1hbi1wYWdlcyB3aWxsIGRvY3VtZW50IHRoZSB0eXBlcyBleGFjdGx5
IGFzIHRoZXkgDQphcmUgaW4ga2VybmVsLiAgSXQncyBqdXN0IHNpbXBsZXIuDQoNCkFzIHRo
ZSBwYXRjaCB3YXMgcmVjZW50bHkgcmV2ZXJ0ZWQgYWZ0ZXIgR3JlZyBhc2tlZCBtZSB0byBk
bywgSSdsbCBrZWVwIA0KaXQgdGhhdCB3YXkuICBJIGd1ZXNzIHRoaXMgY2xvc2VzIHRoZSBt
YW4tcGFnZXMgZGlzY3Vzc2lvbi4NCg0KSSdkIHN0aWxsIGxpa2UgdG8gc2VlIHRoZSBrZXJu
ZWwgdHlwZXMgYmUgQVBJLWNvbXBhdGlibGUgd2l0aCB0aGUgDQp1c2VyLXNwYWNlIG9uZXMs
IGZvciB3aGljaCB0aGVyZSdzIGEgcGF0Y2ggYXJvdW5kLCBhbmQgYWxzbyBtYWtpbmcgdGhl
IA0KPHN0ZGludC5oPiB0eXBlcyBiZSBidWlsdGluZCBjb3VsZCBhbHNvIGJlIG5pY2UuICBM
ZXQncyBzZWUgaWYgdGhhdCANCndvcmtzIG91dC4NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCi0t
IA0KQWxlamFuZHJvIENvbG9tYXINCjxodHRwOi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVz
Lz4NCg==

--------------CpwXMdjcL5eWQ3sq6aHwwBG0--

--------------8EOuW8OYc0VexqmdxRQshbyB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMHK+MACgkQnowa+77/
2zL0BQ//Vac9I5xS19lD9r//k7GdNbczCwChim/KhRkz+eiqJP/qte0upVBsMcG4
9dBCuriFK41rlsX8axY3t1jIinVTlLBfrvt8q+OrlS5foDTI5JMY8aVoAVWL5Tox
a8s5hJFyqlpdxFBbZzz8gZUuv1ZK98fpgoqjYWgqn2ksgei+86rck1XGsrfwC9GZ
FNOwbhlOmTrsl7H3DhllQ1g0uDvaO0HGzya8EG48m94FH4QMeL/5Gh1BVRsohvDC
xNo6Kh33XxMmBem8NUqnBNd0Xl0AG5C3M9ydWZIsFzhtT+27oa4LGH3IJ4CTBdVE
tFCbEem8YOKgBBVtF6/m9sXBjaJIHZbHwpscjJZPe/nWG0FvfT6RcJihflBEfCk0
K6R7P5GDCFqP9FFcJTYOgq0B2Fn4RfahcU9Q84FyS1Wpiz4kgl8ULtT5r0Tgvtsh
Rc8wM9Jq4qUVSigxa0w9/eLGvgXk1Ya4/0RO3gqXtjziFisZgMOOOafcKKCFzomX
+xjv1GtfO6rlYsPKtnrbUZ2LFTeEdaAbCMj+LSqkvq3dLq5cHG6O93wLauKY92v/
9wg0Z0YGz5eRyGmmXw7J1SVsq6mYVoNnsdfHniWi//xBYnT1I7L7ebQcwQ+Exs0W
8ixcdeY/nZedxEP6d3qSvwKpx4U742sRTrGE2Mf+hC7GbaxBH40=
=HwCa
-----END PGP SIGNATURE-----

--------------8EOuW8OYc0VexqmdxRQshbyB--
