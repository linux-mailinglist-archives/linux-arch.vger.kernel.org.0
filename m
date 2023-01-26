Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF6267D52E
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 20:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjAZTOd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 14:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjAZTOc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 14:14:32 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9292720;
        Thu, 26 Jan 2023 11:14:31 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4c24993965eso36487737b3.12;
        Thu, 26 Jan 2023 11:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MBaflCYw2m4ZpSYc/L1jwPBbC18VWFzN42/SpYCj2js=;
        b=bHAnbg1qrvnjFDBq4rDAEAtuPzYtSeM884V5t/BDJUvSPa4oE6QHpUQrdKHepinthY
         0pb7G2bSubps2A+l0PMZ+helB6y0qtS2IUwGvbHoWxgGhKqhpEzG42wRh512unI5VHt/
         AmIdu3Eoan6D3ezRzU66gub3AuwNvPhWL+ByBPZCawbS5o2k0XZf/oubwhyIZku8mW2u
         pwQDz5oLoUzBvnFb+nUf3TBrt1+mS+4OmzMTGO1PMbxOrA+cfQguoHSHhIjo7BvZTjii
         DC4BmYixGumZlYPOa6RX8hlmusN8cR/YkFINMUfQt92/el5jqRaRU01nOG/RazAz0LbP
         pMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBaflCYw2m4ZpSYc/L1jwPBbC18VWFzN42/SpYCj2js=;
        b=VOfM8o5eH/aOo6NAkCoElLr8lt1itswUWDlCwzLKxl2Ay7i29PfYsFQ3r257Ks+QT3
         zvcy1hcLnfstJnLhPTh3UAuukVfJ0Sd8cpj8YItm3WPjBQlgEsiA647mTWT4VOQh4tAM
         rjiMATeL3ljPWdFoDfogiNpdw03bJZMvNKx9jzJ995r+VMGTWVtdfuhKgs91l+YZJOzR
         ENua/SO/2AJo0fq+hmBk+Xq0SZLYm4Z4UVDTFpQqZWPCWGpHXZ16iwiWQ7BbWYZOZSrf
         fpQx1+VWc09EnKqn6KbBY5gfjBWLzxwE8Ct6vXN815u3uy850bdJaSdw5fDUxAoxb+wE
         XQUA==
X-Gm-Message-State: AFqh2kpB/tixc+MnV5xxOdrIyJ9x7+LXLYvs068U5DUms08dbrxK4fLc
        amYBsOH9ogr+DyPUfFQHOj6GrfTu+5KiWNq5KL4=
X-Google-Smtp-Source: AMrXdXupcW0FnUSj2qcKDJ+i5BekGrYWsKP2NEjPHQ96FZBN7tvseY5dVT/oMmNzyu5LA/vU+un2CYi0wXZ5jEg6QOU=
X-Received: by 2002:a81:5402:0:b0:3d8:8c0e:6d48 with SMTP id
 i2-20020a815402000000b003d88c0e6d48mr3099310ywb.462.1674760471019; Thu, 26
 Jan 2023 11:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20230126172516.1580058-1-guoren@kernel.org> <20230126172516.1580058-2-guoren@kernel.org>
In-Reply-To: <20230126172516.1580058-2-guoren@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 26 Jan 2023 20:14:19 +0100
Message-ID: <CANiq72=Srm7aBu7Stz8-t1PkhFsPXUyoxaLJCLJHG9b6mVc8sQ@mail.gmail.com>
Subject: Re: [PATCH -next V15 1/7] compiler_types.h: Add __noinstr_section()
 for noinstr
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023 at 6:25 PM <guoren@kernel.org> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

If Lai is the author, but you are submitting it, shouldn't your
`Signed-off-by` be after his? Or are you co-authors? (but then it
would need a Co-developed-by tag)

Cheers,
Miguel
