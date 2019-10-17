Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3B2DB1A0
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 17:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393660AbfJQP5M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 11:57:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45063 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395161AbfJQP5M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 11:57:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so3094211ljb.12
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4PxrQs933+V5oPr8OiDPqaIoIpZGdDzzkOimKTQV2g=;
        b=Kr9BX/cfb2sRs/x/gvHEtXyzQS5zk4Q/8NCTTHXajgSTd++3vDJnhVRTc0WubtBznW
         17w3e3Wtmf8DvpoVUcp60cqBzsxrYz6XvlxjSYPuz/8UKaejLoeDl8sW1yae4Ebh8CPV
         Ceo1GVuR2CjrWoxZH/cNMPkslfMjIDmNExrMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4PxrQs933+V5oPr8OiDPqaIoIpZGdDzzkOimKTQV2g=;
        b=jOUBn64QylwCSdaD6ZPiulOVV35PNztNbYUAOYhDKG61NUbLpzSaLUvFZXDceSdFvW
         C/JBq5SH9+LeGSKFdVIl/LMZQFEdOJY628sBcwz1JZRg6cwvdcpeViCYRx9rK7nKVR21
         Ld06ZJuuVG5sra5WPw5KuEPloLAdO4hHbAv8aSCrC8j7P/tCN40Jxgl8CSt7imn2LHg6
         nOoXA1vk3UjlkNzjSw+fb+f7iEgi3uKtZCCnRTq8VbgnQpsCGyB2lMFSe8jMujdzhpFe
         5WagC54Yd7bgI9Ui0eSSJXukRiayeAxfFF+BOXFo7GMeo5vV8EtW+6P4Ma4zu/PEEiR9
         2SxA==
X-Gm-Message-State: APjAAAWdWV4EjuTS6AhQJjMqip/YeLpu318DHlpLriNnipHXeezO2jaU
        jQuEL0wwHvn9YlahiKa12JDEHmI6m8g=
X-Google-Smtp-Source: APXvYqzzQWn1Rz44E+kywVxVmFhrVJ+/c+8wO1WnzPILXCL+zPMKxH4QKTeD686Gdotmyy8p7kyBpw==
X-Received: by 2002:a2e:9d06:: with SMTP id t6mr3075253lji.253.1571327829964;
        Thu, 17 Oct 2019 08:57:09 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q3sm1068154ljq.4.2019.10.17.08.57.07
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 08:57:07 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id y3so3125936ljj.6
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 08:57:07 -0700 (PDT)
X-Received: by 2002:a2e:8310:: with SMTP id a16mr3140871ljh.48.1571327826778;
 Thu, 17 Oct 2019 08:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3uiTSaruN7x5iMaDowYziqMFxKWjDyS1c8pYFJgPJ5Dg@mail.gmail.com>
 <20191017125637.1041949-1-arnd@arndb.de> <CAHk-=wiH7Ej9x3RqJkUEW4hDCisgWdi6wai6E0tvo4omF_FbeQ@mail.gmail.com>
 <20191017153755.jh6iherf2ywmwbss@box> <CAK8P3a1TrOippPUh6Fc_McHcp2LOerdD6ifmcieuy0bAFPvs8g@mail.gmail.com>
In-Reply-To: <CAK8P3a1TrOippPUh6Fc_McHcp2LOerdD6ifmcieuy0bAFPvs8g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Oct 2019 08:56:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8MsquobFL5TC0yUkG-9yFUZZnikMPA8QHLc7fcyND6w@mail.gmail.com>
Message-ID: <CAHk-=wh8MsquobFL5TC0yUkG-9yFUZZnikMPA8QHLc7fcyND6w@mail.gmail.com>
Subject: Re: [PATCH] [RFC, EXPERIMENTAL] allow building with --std=gnu99
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Pinski <apinski@cavium.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        mm-commits@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Ingo Molnar <mingo@elte.hu>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 17, 2019 at 8:47 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> For the record, that seems to mean that moving to gcc-4.8
> would likely not cause a lot of problems and would let us do
> some other cleanups, but unfortunately would not help with
> the compound literals.

Yeah, that's certainly less than wonderful.

That said, there's no way in hell we'll support gcc-4 for another 7
years (eg Suse 12-sp4), so at _some_ point the EOL dates aren't even
relevant any more.

But it does look like we can't just say "gcc-5.1 is ok". Darn.

           Linus
