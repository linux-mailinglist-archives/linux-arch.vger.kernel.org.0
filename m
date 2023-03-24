Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F96C749E
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 01:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjCXAf1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 20:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCXAf0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 20:35:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E519C1B320;
        Thu, 23 Mar 2023 17:35:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id fb38so294008pfb.7;
        Thu, 23 Mar 2023 17:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679618125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wmof/czDiZPAMVKVcZuACGS2ZwREuoODzaXC73kpCeg=;
        b=iiDJl9/TSEUGbEhxvuYtVLJTxYPR26FAC6pJLRz0TZmXt20Uw9+grV7dSd96+mKsvP
         zjVA2eab2ux2HBV5gjGezNnbCFXJFXZkY6ed+8VhvgjZ8Igo22VfpppJYkc2i+kbGYJS
         einPZNisfA72vK/A4m8KtP61yD4Z1gTReTao6TpBUiyE0hBQrOYWavF2mGT4eP6meHpz
         bim1MizaS88bHY0yeOwuuH/BUVjuZ57CgqtAPsf4KtrEMgupf7qvGz+30SOoIUMehzKZ
         JmUvZPdZybG+7NNj5LgG0fPpSkWVhppBAjHpj/9rq+aLNNset8kIk//YbEDwDeosto6T
         k6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679618125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wmof/czDiZPAMVKVcZuACGS2ZwREuoODzaXC73kpCeg=;
        b=xmQRVzr9AR5/R6tsDpEynpYqyMUuXC4zKodOvRy9VnyO789gq4TDE0mZDHbL2P+mkV
         fxkPTn2vAY/dzbJ1OXLlgl+Aeka3Biq82qn5BdHlDByavtwLjKA7eLJkFfq6fh/SXHwB
         cX2nWfouszi4tzbk/5NokBWfO+84ep375oC2eLuyjZexTB1SJTOfcLPFoGRS6ptM067s
         8HUwD64HuMXIlhVipQ7BMiiLGUgygDG7jpYYUf0f9FQRpx1mmcJ/ux1FmbxAU/BeKhR8
         pVHVu6VvedUAg2kYXIcylFs0an8zzHNXLMRxL9X+278vGZ4ORKrC6iqt/QbkdMaIegI6
         p1Gw==
X-Gm-Message-State: AAQBX9dojwaTYLkWZ/mtAYKlwZXLEIXZElwdNT0v/tgAiEVxQjTLaRMX
        QRTfSuqGiwjE/IAH8q48nZZky65Wh5zWswtxzRc=
X-Google-Smtp-Source: AKy350ZqJS40tTQ6KRlG0RyxlPiAVUDSJC7QOQ8yVDKWjE+ryc06E3chvR7YC9kCUrnoprQWV8qSrDyDAs+bNpP6Z1s=
X-Received: by 2002:a63:66c1:0:b0:4fc:2a22:898a with SMTP id
 a184-20020a6366c1000000b004fc2a22898amr95461pgc.3.1679618125440; Thu, 23 Mar
 2023 17:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230323221948.352154-1-corbet@lwn.net> <20230323221948.352154-3-corbet@lwn.net>
In-Reply-To: <20230323221948.352154-3-corbet@lwn.net>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 23 Mar 2023 17:35:14 -0700
Message-ID: <CAMo8BfKg+Gx6i6icZCBg=EqvXtwze0+ToG7x8kA2z=fwOoDxYQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] docs: move xtensa documentation under Documentation/arch/
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 23, 2023 at 3:20=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Architecture-specific documentation is being moved into Documentation/arc=
h/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.  Move
> Documentation/xtensa into arch/ and fix all in-tree references.
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/arch/index.rst                 | 2 +-
>  Documentation/{ =3D> arch}/xtensa/atomctl.rst  | 0
>  Documentation/{ =3D> arch}/xtensa/booting.rst  | 0
>  Documentation/{ =3D> arch}/xtensa/features.rst | 0
>  Documentation/{ =3D> arch}/xtensa/index.rst    | 0
>  Documentation/{ =3D> arch}/xtensa/mmu.rst      | 0
>  arch/xtensa/include/asm/initialize_mmu.h     | 2 +-
>  7 files changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/{ =3D> arch}/xtensa/atomctl.rst (100%)
>  rename Documentation/{ =3D> arch}/xtensa/booting.rst (100%)
>  rename Documentation/{ =3D> arch}/xtensa/features.rst (100%)
>  rename Documentation/{ =3D> arch}/xtensa/index.rst (100%)
>  rename Documentation/{ =3D> arch}/xtensa/mmu.rst (100%)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
