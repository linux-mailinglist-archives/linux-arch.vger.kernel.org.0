Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC011BCDD
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 20:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfLKT06 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 14:26:58 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:60335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKT06 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 14:26:58 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mt7Ll-1hqKMr2ziz-00tQbm for <linux-arch@vger.kernel.org>; Wed, 11 Dec
 2019 20:26:56 +0100
Received: by mail-qk1-f171.google.com with SMTP id r14so12513622qke.13
        for <linux-arch@vger.kernel.org>; Wed, 11 Dec 2019 11:26:56 -0800 (PST)
X-Gm-Message-State: APjAAAVpYQw1luQ7IQgc+5KKWp+3s5R84J+D6x+cZx29lfPUo2BJEZc7
        8O25iHupn4du/Zr4qfCbUzJBhcr7uoljhnU7Hs8=
X-Google-Smtp-Source: APXvYqzp5gI76+hnxf6/hmrPMG5/BvSczTPLPStullb7LcktBYw4tJjRaFzZ4zVRtyE/ktu6JAXLohEVRyxYWiy1yZ4=
X-Received: by 2002:a37:b283:: with SMTP id b125mr4686863qkf.352.1576092415604;
 Wed, 11 Dec 2019 11:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20191211184027.20130-1-catalin.marinas@arm.com> <20191211184027.20130-2-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-2-catalin.marinas@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Dec 2019 20:26:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0OxNWPjekT_m55reuopHJeWZs6dm7YTtoLgd39P6y2PQ@mail.gmail.com>
Message-ID: <CAK8P3a0OxNWPjekT_m55reuopHJeWZs6dm7YTtoLgd39P6y2PQ@mail.gmail.com>
Subject: Re: [PATCH 01/22] mm: Reserve asm-generic prot flags 0x10 and 0x20
 for arch use
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Au6++WlhDRotoAStorv/8gB/Mq0L6qYsAeEpxvMuCDs9AdMxcXb
 X7VwhrUkECw9r9ICnEK5xXZ6Z+GlqfXGQxKEm27Wc1hgnP1TvxcwN0GfNdEiWUcalrKM4LG
 +rog8MquJPDn2vnHijIXbgcc/IPU550yuPJBJ8vTzok6o1WV3tN4e0gffb8XlOuIIA2RAi2
 J96ECUg5tvH4SaOd4Gsrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:opH4vRCleSQ=:jtFfcpfvUdEiVOm4nXaiUB
 JhBf97cHkspIrWMbBh2RgujZ5um/VI2HZn7kQKVrkRlJx2hl8j08SC2mmoXzgCo6a+k1kChj3
 m8n7/NA6ZII9QjXPY+dxA3y1yLKRXUMy1RO3So8RdZ1C6Qh/4Imjjmdh9923ziV9EzYWr4PrX
 xQtTq7FNHR+m83ScFqFAuLrbIPuF6qsRIvLyLPF9OEIP83Tax6cOBniDVBBBcU8HMZ1ExP4hy
 EkuI6aMzQ2XwnJcEam/xy6NC26+IjSOSiRjATwst8fIHxCj3uQoo9QnF6tLBKb1XoCiG9CQo0
 RGQ3s9tBgxJ49S2GIiqT7+iSTLXEkAQko4Cc9cwcm82YJZNt06NlTRJVE7c37dev9efJHsANr
 h4At2VfcCxOYhMY3rOB7q9QC1U3WInd/Zzd1//e3W0Ith5UZIu4cDPt3e826sJl40UmVS5NE9
 U/atfP11+gCXjiaPhZPFMsANUd5qDbtRbffYR9yZhBA2E/qBRVGcPYMeUfw5KUmfyJrr+Iygc
 ZeuDXmcM3ae6UXA/iHcQLEha8uuroNtcC4HH/3LxdMivPVg4o1ki1t9wVxz7FNovX6pL7Qi55
 nH79R85m9TRDx8nwT1wN19qYYb24ZxTHPER6iH5J5hf4lHjcuZ7t7Qk9dd/5U92iJzDQuRTgx
 FgZdlJahlJMWJWm9/XjmGkP2dAKkmT06F1AM/QdV46+jCedAOs0MNE2fT3kWn7sw5OrW1TKMk
 lJIGkgERMcQWUwrmL812HOvN7KNOjTqY3YwsD/Ap6aWCjtSCWiLM87O/A4VcGnVMfvDYSTn1K
 TwwDl/xmmDhdJH3z+2G4Qs2zS6HvJgF32e6VbdHQyyXKTeYH9PeE1SlQe7RP5oFZfGaFBWBnG
 uppXJzVflbqYhISXk8+g==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> From: Dave Martin <Dave.Martin@arm.com>
>
> The asm-generic/mman.h definitions are used by a few architectures that
> also define arch-specific PROT flags with value 0x10 and 0x20. This
> currently applies to sparc and powerpc for 0x10, while arm64 will soon
> join with 0x10 and 0x20.
>
> To help future maintainers, document the use of this flag in the
> asm-generic header too.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> [catalin.marinas@arm.com: reserve 0x20 as well]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
