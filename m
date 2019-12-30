Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216DF12CEB1
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2019 11:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfL3KVl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Dec 2019 05:21:41 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:33837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfL3KVl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Dec 2019 05:21:41 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MQvGz-1j9Bga1pVH-00Nyh9; Mon, 30 Dec 2019 11:21:39 +0100
Received: by mail-qk1-f171.google.com with SMTP id r14so25901882qke.13;
        Mon, 30 Dec 2019 02:21:39 -0800 (PST)
X-Gm-Message-State: APjAAAUyA4e22vK4esaahomP1amX0iLHjiZSy6IE1RcmKcNQDInpwsEG
        8hDV2gz+q8HCho9n37KLBqDVa02aMpMXpaX3vY0=
X-Google-Smtp-Source: APXvYqzoX0OqCIDFL1Us7YAWuEEYxf5rBU2+XanWAU+CZlXKx2JHkQPiucY5FMII7XoOCHvdsvFPFmJKsXgHvGsBY5Y=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr54185045qka.286.1577701298243;
 Mon, 30 Dec 2019 02:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20191223110004.2157-1-rppt@kernel.org> <20191227110736.GA30363@rapoport-lnx>
In-Reply-To: <20191227110736.GA30363@rapoport-lnx>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 30 Dec 2019 11:21:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2ofBtooPi1ARCaHaJa9zRUVP_DKO1Td3WUgvO-0HnPSA@mail.gmail.com>
Message-ID: <CAK8P3a2ofBtooPi1ARCaHaJa9zRUVP_DKO1Td3WUgvO-0HnPSA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix recent nds32 build breakage
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:OakknFVba80bLW7q5xxALsPjf5Jde0FegdpoRU/zsDbqqUStxZR
 GjbYAX0Xmwv7iIHAyRlYFnE7Pd/W9lADl5Zp4xdYYQmx7FsyreGUgbFkpfa8qbTTln/Jx9m
 5Y5kPPzeDaOc8OtaGAiZVRODGR9uNN/IrW8R+tQWHWYHTe1cxQaqRSm6wxUE0D4TTqc6c3H
 LKM0IH/UR6614wQJCleNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WdXzbd8/Mss=:0XBl1TMV7gsMoNl2Lt6gFj
 y3q/HlJLuq0uC1DyihNlpR7SV3909d6Nl1Pl/EYa3cpjPTmGwxpqGsVajiXjqwrDSZIVKvmwN
 kZwI280rRNKjPGmkiNyLbEMiVECS0AWm8J/g1aZ5Nq5yL+1h7dSJddIrPpduXrG89U2COcqgb
 E+2e6N2POW/i4YkvcmVBdMGUR3hlWISb7Fn9ffd2fI0xU21dM3l2MdGzcBxdB6e7v4qfU1Ayw
 u4LND2hkosr0q0d6k+pcNXDU0i5SgOuCJvUAQnIJR2A4DxPl1JWr0ZIrsPNnN3sNhhg8Z8F6r
 7SuCMPn1rv0xdSpWoWNKXF5Zs1o9UYC9OKjGnO7aRjYn3/Rue66eAyIRp9aY1089QwEnihwNG
 mw77E9AKo/9ZbOKtlk01A6CKSx46DLuQKMoVFiiZIW4bQAalMqsBWKhFkOvv1sJIyWK5EzLcz
 Jiz84dh3btBXJhsGcYBKl7KKQhGe7sPsMnjtM784mwI8dOWoou8K1UgX9MuW8zZ0Mp1Md/rmO
 0GSY+1JjjLl7zo4NpFtLeBokVznrA8wHyj6UVPc/1q07ahklklPfKQ7HcqsbsPX5Px31bDeXk
 h9mBj7VzKD9ZlBYCnEeioXaXwNu1ubaTLwgs9ki/wsghh4JjYql9aM336tPouoaluLa4WRzkz
 5TZHQ8Szb9tVL4yXTgq0p4mVqJp/YJaw6+MkASao7R/cy9MKml/qpvePYQ6rJREDRZrQegoUM
 Pg63sfWjoXyX1rJSZHsevl8tqYxF1JIMq+Ir97bfcWfc4miBuBJwTzO8FM9lyEAepiGV4rNra
 5c+h8Mzp6j91LOWaBkE6dCjclsBwUuyjiXKo4GeORoMfWZ7h9cNRPBlrWcsun7K5+JCecnsAO
 JOJu4coMZyLGltlOOLqw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 27, 2019 at 12:07 PM Mike Rapoport <rppt@kernel.org> wrote:
> Can you please take these via asm-generic tree?

Merged into my asm-generic tree now, I'll send a pull request in a few days
after the build bots have had a chance to check for remaining problems.

       Arnd
