Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6444B09C9
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 10:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiBJJmz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 10 Feb 2022 04:42:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiBJJmy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 04:42:54 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5ACB8;
        Thu, 10 Feb 2022 01:42:54 -0800 (PST)
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N6KpF-1oON1B2ubp-016fKk; Thu, 10 Feb 2022 10:42:52 +0100
Received: by mail-wr1-f52.google.com with SMTP id o24so5799634wro.3;
        Thu, 10 Feb 2022 01:42:52 -0800 (PST)
X-Gm-Message-State: AOAM532/HSira21YaoUeLlFKj2aA0oN2Hb0hoYliLyGBgf1VU52Bbe4i
        uVjVhrQIsRQaSlNvXa6E8EZjB3/q/1e8a8DUnK4=
X-Google-Smtp-Source: ABdhPJzhHs9stg1CGjBG4tYNZmGgHgYXJf8g0kYd6wB04Op66IuXzXvecmd40GTVBsPrfi8m3IvRyQ/IC3YdpZH/xvo=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr696840wrn.317.1644486172328;
 Thu, 10 Feb 2022 01:42:52 -0800 (PST)
MIME-Version: 1.0
References: <20220210021129.3386083-1-masahiroy@kernel.org> <20220210021129.3386083-5-masahiroy@kernel.org>
In-Reply-To: <20220210021129.3386083-5-masahiroy@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Feb 2022 10:42:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a20A4bMNYiLCgaPZbnAG-gY=c5Qh_AqbupF3kLYUz5yZg@mail.gmail.com>
Message-ID: <CAK8P3a20A4bMNYiLCgaPZbnAG-gY=c5Qh_AqbupF3kLYUz5yZg@mail.gmail.com>
Subject: Re: [PATCH 4/6] fsmap.h: add linux/fsmap.h to UAPI compile-test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:SKFBc6gh2BQcpDMOOfR5sBuuKK6JA4YwdeXfHeOqsJTo1BqQp+Q
 vDb6a6EHi/CGoN105kxDSq1BrVdWYbnY1gAfg7t36fDIfsWRMjj6tyHSdDOgusICDXmdJce
 qwMMScjjNCGAL8e4ulAdqfqaO1yVRlNEyBKU3wbMjsna9fZgyMsAzZ7gMi5FfxgLxjOgY/T
 oiM4cTkFq3ozKZ6SQ5GXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FvvoPiJvMLg=:x70AYA8UT3KJCdbwfBIuh8
 zXRs2tv4mOrNoDvp83YN3oPxcGqQzP6Q4wAQmLL2kXCSVzwe+OL1L8btAOwMw/3/wgGd1Rk0J
 HdOPI0RCW+TKSb6XJ097CenjHUPQY2fnQMd56+HWcEQotyO6XhJia8wPJ3LtFPM42unIZwCLJ
 WRzak2zrqysMZ8brYVpoTjUAkgUNEOnw0U47XIJ91Fersdg89/v888V0HWdr6BgafuDf/KgkN
 pw6rw8uMVfbYyIQZHYP6QcOv1JS4faXX4eGZuW8f/fk3BWsFpJZsYUJGUpyx0Hjdg/QrQ5ZcC
 KfXbLzytaI3HMDbNXwwKpn69O74/Z7xiG/wX5U4nN5Def3IVR9I80jpVeQkKhpAGAtkZYn7Dm
 hLR2W+gblrve1hW6p7WGngOWEeV72fqIjjaU32D2XygdaOs/F7yyfy0nfkHB5SwmtvwnhJtf/
 WJqFmnM+a5Cp7nYewiX6ccP38EKK/8iaFLG3vkVAiIX82o1r/SUzl/B0sS14qKDF/ult0sB6Q
 0UhML/t8YBxDwKm6eWwOYSbD+T/jw6cPZwX0zJQ/ib7wf6oEYzqueCzsPDgcguFTxdKP7koj2
 Tw+6OVQ/lSr6+7jyzYJtcs91je5skSnWbaeEH+IlSyyLwCiplFNvQOXLlZj31OyWYBD+t2ySV
 XoymN4FNGF4ZUYzUYrPQJP6Y/GptZjylnsp+2u++1lYTdHg1zZ+6tJAwsw3i+XhkyVeVWoUsm
 qmPeDfikSexYe6wLRDuK3gPp8YB6R9dYHnyqZEPM0SXTXegVS1Nk/K1lKLMCy+R7OL4c4v7sd
 aYwrWw8kLfO9gohTkyqL5CNiIPLd0Yu5j5xLNoqPd3i5x4wClE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 3:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> linux/fsmap.h is currently excluded from the UAPI compile-test because
> of the error like follows:
>
>     HDRTEST usr/include/linux/fsmap.h
>   In file included from <command-line>:
>   ./usr/include/linux/fsmap.h:72:19: error: unknown type name ‘size_t’
>      72 | static __inline__ size_t
>         |                   ^~~~~~
>
> The error can be fixed by replacing size_t with __kernel_size_t.
>
> Then, remove the no-header-test entry from user/include/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
