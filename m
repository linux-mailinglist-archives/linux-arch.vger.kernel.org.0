Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EC4561575
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jun 2022 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiF3Ixn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jun 2022 04:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiF3Ixm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2022 04:53:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9EA3B542;
        Thu, 30 Jun 2022 01:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DEEFB82924;
        Thu, 30 Jun 2022 08:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6F1C385A5;
        Thu, 30 Jun 2022 08:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656579219;
        bh=98LP8TqrAriutG23cVTk9h4C/uw9Lw8fbs5WwhfVi40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pCfiIOuRlS6deNhUfZbpGjWGIVTgcU0TRbrE7TwiGCQmgN9h+Y0+o3y8lEfj18X77
         RNUhjvbez2W1w6C/exIBHvBpRc/fIV79Subv49LmORt2pGCJvv7MuOt2sxyHeB4taG
         4uydP7XdjpETqE5JlfQQzv2k8snm0uZT5+DRQfQUAFTGZMSmFocpnnHQM1H0fOZECM
         V/v05y+Ym3VHBNrG1DAIqZMGh4L8Ky/jyN0i4jTqNy5yHwgs6LdlT73i261gE+fdt1
         c7aIO8r3XE+6GTt4LQL6RU+YQ6kRuxk4KyCQCtq7Hquecwd2ESdkKwDWhFzBGzXRPx
         L3ujRJ7vRnVeQ==
Received: by mail-vs1-f48.google.com with SMTP id z66so17610203vsb.3;
        Thu, 30 Jun 2022 01:53:39 -0700 (PDT)
X-Gm-Message-State: AJIora+eIBBT+PpgIbzPV9mlb+hawx4UqYqSJ6YGlj52BDWfT/0R0AX7
        va89nUJx2sCi3MKgbNC+v1n1KMJkD3i9bjMe46Q=
X-Google-Smtp-Source: AGRyM1usGSpW65/S+D3bTGvnsIsuanAbAX0oa4OCyYXk/MFf5yU3THi8COlykfUvDOw9YX5tbgBR13xexsBTWE/4zc0=
X-Received: by 2002:a05:6102:6c4:b0:354:3f88:4d3f with SMTP id
 m4-20020a05610206c400b003543f884d3fmr8085454vsg.78.1656579217987; Thu, 30 Jun
 2022 01:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220630043237.2059576-1-chenhuacai@loongson.cn> <35094088-d5da-cd36-66e2-5117304c5712@gmail.com>
In-Reply-To: <35094088-d5da-cd36-66e2-5117304c5712@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 30 Jun 2022 16:53:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6NubNmoNvOkjnDT925O7Kb0yKPDKhGXroxhrU+AuECfQ@mail.gmail.com>
Message-ID: <CAAhV-H6NubNmoNvOkjnDT925O7Kb0yKPDKhGXroxhrU+AuECfQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] mm/sparse-vmemmap: Generalise helpers and enable for
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Sergei,

On Thu, Jun 30, 2022 at 4:30 PM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
>
> Hello!
>
>    Your subject looks unfinished...
Thank you, this seems because the subject is too long.

Huacai
>
> MBR, Sergey
