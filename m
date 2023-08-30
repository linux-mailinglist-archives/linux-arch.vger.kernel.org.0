Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD078E0E9
	for <lists+linux-arch@lfdr.de>; Wed, 30 Aug 2023 22:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbjH3Uq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Aug 2023 16:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbjH3UqS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Aug 2023 16:46:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD0CEC
        for <linux-arch@vger.kernel.org>; Wed, 30 Aug 2023 13:45:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d20548adso726f8f.0
        for <linux-arch@vger.kernel.org>; Wed, 30 Aug 2023 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693428241; x=1694033041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1V+IGdRyJRzIXYkK3ZtH0ylxOSZQ1q4yqJcT6PRMsv0=;
        b=R2u2bT2o8W8R2N/AtUryzSiWdBDu1FU8VZFw7qyLgIhzB6xc1HLa5j1b5aAV92AYpR
         BJI8gfRLeQaEHYT9JdUrEmM8ehghSNFmenWgkJ0ldN2k8JJFunGaec3z0mvGfaivxgpG
         hXSvS1aR54Najquupuzh9QnScdU8Yq5HC1434=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428241; x=1694033041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1V+IGdRyJRzIXYkK3ZtH0ylxOSZQ1q4yqJcT6PRMsv0=;
        b=i9wa+a4pla27lL7jsRcUuims9jnWkHkg/LZ75IgJ2o6rVj9C5PTR3jPl0lQac7+aPN
         gPVvtJoTXrWJW6A29oVAk1+ofiLvHdSUByM0m/eDAh+NdAj9cy2MOPY5dJfuGI/aJWJk
         6Hh45In00ZF75AKGFexYjT9bbIUqJszjzZ3h3dMlKjhF+79FZ1BrFSGYREC8NFIKM8Ak
         OGqUy9VPDVtD0iqVn5wxIf5kGZP1Xpd+0vPhq5bzNV3di3HSGPYecinc857XrfRedKLM
         2WXLLqGGgQOXnAZk8dic9G6i1e5C8qN536sw+WzEPlCyQJ3BvX4t7jupTxT/mpIW5Bck
         DcaA==
X-Gm-Message-State: AOJu0Yxv4nsrZc3fIbKspa5mO3xC9S6pwEneYiADsuqmFnQS4P6u4gpd
        9y8iBJIFN21zQlKjrePldQi3vheJ3tED4HmzocaKCCyL
X-Google-Smtp-Source: AGHT+IHjpxD2C88vQzJ5Z4Td9zDU7ukIZQeAckL3J0MJkl7gsH6XSA87mYC/cXAKB8+AuzRxB4a52g==
X-Received: by 2002:adf:cf09:0:b0:31d:cd33:b30e with SMTP id o9-20020adfcf09000000b0031dcd33b30emr2165895wrj.4.1693425664947;
        Wed, 30 Aug 2023 13:01:04 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id bj13-20020a170906b04d00b0099cf9bf4c98sm7529969ejb.8.2023.08.30.13.01.01
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 13:01:01 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9a2185bd83cso3149866b.0
        for <linux-arch@vger.kernel.org>; Wed, 30 Aug 2023 13:01:01 -0700 (PDT)
X-Received: by 2002:a17:906:2d6:b0:994:54ff:10f6 with SMTP id
 22-20020a17090602d600b0099454ff10f6mr2316759ejk.30.1693425661231; Wed, 30 Aug
 2023 13:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com>
In-Reply-To: <20230830140315.2666490-1-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Aug 2023 13:00:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
Message-ID: <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: multipart/mixed; boundary="000000000000fe07ea0604296283"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--000000000000fe07ea0604296283
Content-Type: text/plain; charset="UTF-8"

Side note, if you want to play around with the user copy routines (or
maybe Borislav wants to), I have a patch that handles a couple of
common cases statically.

It requires that we inline copy_to/from_user() in order to get
constant size information, but almost all other architectures do that
anyway, and it's not as horrid as it used to be with the current
access_ok() that doesn't need to do that nasty dynamic task size
check.

In particular, it should help with copying structures - notably the
'stat' structure in cp_new_stat().

The attached patch is entirely untested, except for me checking code
generation for some superficial sanity in a couple of places.

I'm not convinced that

    len >= 64 && !(len & 7)

is necessarily the "correct" option, but I resurrected an older patch
for this, and decided to use that as the "this is what
rep_movs_alternative would do anyway" test.

And obviously I expect that FSRM also does ok with "rep movsq", even
if technically "movsb" is the simpler case (because it doesn't have
the alignment issues that "rep movsq" has).

                 Linus

--000000000000fe07ea0604296283
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lly5wgs70>
X-Attachment-Id: f_lly5wgs70

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaCB8IDQxICsrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyks
IDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nl
c3NfNjQuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaAppbmRleCBmMmMwMmU0
NDY5Y2MuLjAxNzY2NTA1MjAzNiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFj
Y2Vzc182NC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaApAQCAtMTIs
NiArMTIsOSBAQAogI2luY2x1ZGUgPGFzbS9jcHVmZWF0dXJlcy5oPgogI2luY2x1ZGUgPGFzbS9w
YWdlLmg+CiAKKyNkZWZpbmUgSU5MSU5FX0NPUFlfRlJPTV9VU0VSCisjZGVmaW5lIElOTElORV9D
T1BZX1RPX1VTRVIKKwogI2lmZGVmIENPTkZJR19BRERSRVNTX01BU0tJTkcKIC8qCiAgKiBNYXNr
IG91dCB0YWcgYml0cyBmcm9tIHRoZSBhZGRyZXNzLgpAQCAtMTAxLDIyICsxMDQsMzYgQEAgc3Rh
dGljIGlubGluZSBib29sIF9fYWNjZXNzX29rKGNvbnN0IHZvaWQgX191c2VyICpwdHIsIHVuc2ln
bmVkIGxvbmcgc2l6ZSkKIF9fbXVzdF9jaGVjayB1bnNpZ25lZCBsb25nCiByZXBfbW92c19hbHRl
cm5hdGl2ZSh2b2lkICp0bywgY29uc3Qgdm9pZCAqZnJvbSwgdW5zaWduZWQgbGVuKTsKIAorI2Rl
ZmluZSBzdGF0aWNhbGx5X3RydWUoeCkgKF9fYnVpbHRpbl9jb25zdGFudF9wKHgpICYmICh4KSkK
Kwogc3RhdGljIF9fYWx3YXlzX2lubGluZSBfX211c3RfY2hlY2sgdW5zaWduZWQgbG9uZwogY29w
eV91c2VyX2dlbmVyaWModm9pZCAqdG8sIGNvbnN0IHZvaWQgKmZyb20sIHVuc2lnbmVkIGxvbmcg
bGVuKQogewogCXN0YWMoKTsKLQkvKgotCSAqIElmIENQVSBoYXMgRlNSTSBmZWF0dXJlLCB1c2Ug
J3JlcCBtb3ZzJy4KLQkgKiBPdGhlcndpc2UsIHVzZSByZXBfbW92c19hbHRlcm5hdGl2ZS4KLQkg
Ki8KLQlhc20gdm9sYXRpbGUoCi0JCSIxOlxuXHQiCi0JCUFMVEVSTkFUSVZFKCJyZXAgbW92c2Ii
LAotCQkJICAgICJjYWxsIHJlcF9tb3ZzX2FsdGVybmF0aXZlIiwgQUxUX05PVChYODZfRkVBVFVS
RV9GU1JNKSkKLQkJIjI6XG4iCi0JCV9BU01fRVhUQUJMRV9VQSgxYiwgMmIpCi0JCToiK2MiIChs
ZW4pLCAiK0QiICh0byksICIrUyIgKGZyb20pLCBBU01fQ0FMTF9DT05TVFJBSU5UCi0JCTogOiAi
bWVtb3J5IiwgInJheCIpOworCWlmIChzdGF0aWNhbGx5X3RydWUobGVuID49IDY0ICYmICEobGVu
ICYgNykpKSB7CisJCWxlbiA+Pj0gMzsKKwkJYXNtIHZvbGF0aWxlKAorCQkJIlxuMTpcdCIKKwkJ
CSJyZXAgbW92c3EiCisJCQkiXG4yOlxuIgorCQkJX0FTTV9FWFRBQkxFX1VBKDFiLCAyYikKKwkJ
CToiK2MiIChsZW4pLCAiK0QiICh0byksICIrUyIgKGZyb20pCisJCQk6IDoibWVtb3J5Iik7CisJ
CWxlbiA8PD0gMzsKKwl9IGVsc2UgeworCQkvKgorCQkgKiBJZiBDUFUgaGFzIEZTUk0gZmVhdHVy
ZSwgdXNlICdyZXAgbW92cycuCisJCSAqIE90aGVyd2lzZSwgdXNlIHJlcF9tb3ZzX2FsdGVybmF0
aXZlLgorCQkgKi8KKwkJYXNtIHZvbGF0aWxlKAorCQkJIjE6XG5cdCIKKwkJCUFMVEVSTkFUSVZF
KCJyZXAgbW92c2IiLAorCQkJCSAgICAiY2FsbCByZXBfbW92c19hbHRlcm5hdGl2ZSIsIEFMVF9O
T1QoWDg2X0ZFQVRVUkVfRlNSTSkpCisJCQkiMjpcbiIKKwkJCV9BU01fRVhUQUJMRV9VQSgxYiwg
MmIpCisJCQk6IitjIiAobGVuKSwgIitEIiAodG8pLCAiK1MiIChmcm9tKSwgQVNNX0NBTExfQ09O
U1RSQUlOVAorCQkJOiA6ICJtZW1vcnkiLCAicmF4Iik7CisJfQogCWNsYWMoKTsKIAlyZXR1cm4g
bGVuOwogfQo=
--000000000000fe07ea0604296283--
