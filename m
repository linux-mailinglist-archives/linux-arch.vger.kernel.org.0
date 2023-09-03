Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1684D790DD9
	for <lists+linux-arch@lfdr.de>; Sun,  3 Sep 2023 22:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346595AbjICUI2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 16:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346487AbjICUI2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 16:08:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF4AE8
        for <linux-arch@vger.kernel.org>; Sun,  3 Sep 2023 13:08:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so1292540e87.1
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693771702; x=1694376502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xl43q30vAS7+b8YQeYCWjOgGxw9uKWujq0M2fYNGisU=;
        b=Rtmvjb1hQ70UC2qDHgSIwqUqFAQx8l4BgsqAYzx5XU6SGq1DSuDsM5SHHJuGtdU7sM
         sLkGKq0WMC2iswe1DFO+TITo1uzzIXIq0r6XzcK0rfh1oXaZyab6g3WeTTP2b1qNWL1x
         mXLqW4cDCrfAhc4LLLEDA3oKSGWkTmrn52/gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693771702; x=1694376502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xl43q30vAS7+b8YQeYCWjOgGxw9uKWujq0M2fYNGisU=;
        b=VhIc649X0fmKoBtBhyP+uDy3q6tYvfRHw789k9Bf6gGylScvf7f1jjYELxblwF5kRB
         A9jxoN6LFdUHbDFdXNN1uJxppvhQc9mQdMWa4Wr9CrtISKY6zudXQpLiooSh3e+VxqB1
         7hsQurRYEW0TlTZDKWskEQxJ6MFB4kn4Sjyc0mPA6DMECwbjbtGGkoUyp6C3lAnEqosk
         7e2ivJ+igQlndeCiua01vyLXcoR6Ghe6W0CLkfqCJsYQq3IPOVjzTpKPFNwtpCCVv6Kc
         CNuJeXJZFb/tKsr8ZD1Evo9bNbKfxqZiz72DF0nUSkDPv+lEpw8aWwu+hNvDRR3mMAwJ
         fbZA==
X-Gm-Message-State: AOJu0YwMn+cuzkrZLSTLMiRphTz59aPHGcqkfJv7l0/1ORndGA4lYeD2
        czoKD2p+i1UWbejzvSpwqprjmUjpsJ4BjWsR9pcEqw==
X-Google-Smtp-Source: AGHT+IEpzrLzTejDgCwBpL7RVEcBKD8Z8cZNy/BWa4EhYyjpDa5TBm9PDeGOsMRP867aDbQ9uhWQBg==
X-Received: by 2002:a05:6512:4017:b0:4fd:cae7:2393 with SMTP id br23-20020a056512401700b004fdcae72393mr6958714lfb.2.1693771702347;
        Sun, 03 Sep 2023 13:08:22 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id u25-20020ac25199000000b004fe3e0956fdsm1399246lfi.240.2023.09.03.13.08.20
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 13:08:21 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50078eba7afso1303512e87.0
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 13:08:20 -0700 (PDT)
X-Received: by 2002:a05:6512:a95:b0:500:977d:a4e1 with SMTP id
 m21-20020a0565120a9500b00500977da4e1mr2614391lfu.40.1693771700598; Sun, 03
 Sep 2023 13:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com> <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
In-Reply-To: <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 13:08:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
Message-ID: <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: multipart/mixed; boundary="0000000000008c4185060479f49d"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--0000000000008c4185060479f49d
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Sept 2023 at 11:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I have no idea why you claim that "currently they have no choice".
> glibc is simply being incredibly stupid, and using newfstatat() for no
> good reason.

Do you have any good benchmark that shows the effects of this?

And if you do, does the attached patch (ENTIRELY UNTESTED!) fix the
silly glibc mis-feature?

               Linus

--0000000000008c4185060479f49d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lm3vxd1r0>
X-Attachment-Id: f_lm3vxd1r0

IGZzL3N0YXQuYyB8IDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvZnMvc3RhdC5jIGIvZnMvc3RhdC5jCmluZGV4IGYxOWIxMjQ5NzRmMi4u
ZTE4N2RjNzlhMzEzIDEwMDY0NAotLS0gYS9mcy9zdGF0LmMKKysrIGIvZnMvc3RhdC5jCkBAIC0z
MTEsNiArMzExLDE1IEBAIGludCB2ZnNfZnN0YXRhdChpbnQgZGZkLCBjb25zdCBjaGFyIF9fdXNl
ciAqZmlsZW5hbWUsCiAJaW50IHN0YXR4X2ZsYWdzID0gZmxhZ3MgfCBBVF9OT19BVVRPTU9VTlQ7
CiAJc3RydWN0IGZpbGVuYW1lICpuYW1lOwogCisJLyogV29yayBhcm91bmQgZ2xpYmMgYmVpbmcg
c2lsbHkgKi8KKwlpZiAoZGZkID49IDAgJiYgZmxhZ3MgPT0gQVRfRU1QVFlfUEFUSCkgeworCQlj
aGFyIGM7CisJCWlmICghZ2V0X3VzZXIoYywgZmlsZW5hbWUpKSB7CisJCQlpZiAoIWMpCisJCQkJ
cmV0dXJuIHZmc19mc3RhdChkZmQsIHN0YXQpOworCQl9CisJfQorCiAJbmFtZSA9IGdldG5hbWVf
ZmxhZ3MoZmlsZW5hbWUsIGdldG5hbWVfc3RhdHhfbG9va3VwX2ZsYWdzKHN0YXR4X2ZsYWdzKSwg
TlVMTCk7CiAJcmV0ID0gdmZzX3N0YXR4KGRmZCwgbmFtZSwgc3RhdHhfZmxhZ3MsIHN0YXQsIFNU
QVRYX0JBU0lDX1NUQVRTKTsKIAlwdXRuYW1lKG5hbWUpOwo=
--0000000000008c4185060479f49d--
