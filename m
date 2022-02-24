Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1C34C277A
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiBXJEz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 04:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiBXJEy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 04:04:54 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B7518A7A4;
        Thu, 24 Feb 2022 01:04:24 -0800 (PST)
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MWiYo-1nlKm71Ofo-00X7zY; Thu, 24 Feb 2022 10:04:23 +0100
Received: by mail-wm1-f47.google.com with SMTP id l1-20020a7bcf01000000b0037f881182a8so3065539wmg.2;
        Thu, 24 Feb 2022 01:04:23 -0800 (PST)
X-Gm-Message-State: AOAM530FCm5GYNTPUNhsxLPZjBSLMZWXuWIg8HSA9REPaezbRWPguvIQ
        CVrUzD2MVro3CMZbCKcDDdiaMRYotRsx4rldn8w=
X-Google-Smtp-Source: ABdhPJyjEw35XhDO0nptzAMVKk2Hxde9tm8LwW6lNeB58GkA2TxxKPLSRkO1YZW5ApcDqUwIlDhAXRFgLJ95HKAPDdY=
X-Received: by 2002:a05:600c:48a:b0:380:3f3a:e08e with SMTP id
 d10-20020a05600c048a00b003803f3ae08emr10577359wme.1.1645693462887; Thu, 24
 Feb 2022 01:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20220224085410.399351-1-guoren@kernel.org> <20220224085410.399351-20-guoren@kernel.org>
In-Reply-To: <20220224085410.399351-20-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 24 Feb 2022 10:04:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3vmB4Vm9UOHx3qnTY6wUyw_r3R11amYwyHNpEhFiknrw@mail.gmail.com>
Message-ID: <CAK8P3a3vmB4Vm9UOHx3qnTY6wUyw_r3R11amYwyHNpEhFiknrw@mail.gmail.com>
Subject: Re: [PATCH V6 19/20] riscv: compat: ptrace: Add compat_arch_ptrace implement
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hqP+0S9onqPXjEc/plYI652niBmPQNsect9n2Zn0kmP9aAUySLJ
 JV5CqZA6ExYvpjHrNwUeqPQndgnaxyn/FMhuE70Nf5JCQqlRFqrnVgM1PdqmazzSogipLXQ
 AiJ2dp2HAGvlKjxOaGDSWWYGDm4zJv2aViLkM/ccCw4F/AlycXVrRlqlU9DTGlpMj8CyH6K
 lPhaqxyPXj3BykKqOWhVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UFZmV5HYQXI=:4zIeOikdnlT7/1M6xfURhe
 yD3y9gKQZW676YNE3EcSPMFEvhfJoGMJbLPO6AXTBmC2uVWRQfE9S/DW7NZwsrjD4oJwT1pMj
 H1lFJ4mQdP6EFpN+6V6ykRYaGbQtZLQGBYwZirAR5wAy3MUfhq0U/Rn3JLSdIkXzyTR09IzId
 PuEh+dt1NJBQl+JaMqzy3hUM09pzLMxhKgH0zCXpQY3TLt3GWuMCfaKxsytADB6S3vMkuL6EB
 gNQXnYjcoXERIOKEPGluqC5EatgbMrn2yz5LxfX+QLoKOkS2xCYuovSHC83/UGdTnUT92BKLQ
 1TbRFcs+Z+nFgjTWvQFs+6qVMuCuQATvhknEfyWuCiD1BTMX6/fjw4+ApNVgDa7QE13qCdLAq
 bY/d7+REG/kewRLDJ1kdCCFh9117j2gSDy80ZCvo0BC2i4XeSOuAuFrEKY0N+RueYn4E/WJoh
 yX0mdgfNCUAeFVXBSpYaAOC109Ycytki2m6XXKF2YhwPvNWEApv8k4lpbNwvETpELyTbVUaZP
 BzX5doYZN364zRYyh5lzNCv8Z7dRxY0aZW5uN9mR3SOoEQNqsh4LgPM69cWuR5xm00Fv5tklB
 FDPebKiqC72nutCNrZrpxC1d/bL8UU934DukBJDvKzPw2zyOca0x+h8eiNBAr55fgPaLztuZc
 ZqE/uqYeyyjt/YagyqvRkowGe4Bxixe+a+s9Uqwq/8GCELdm9r38J5KXgkppvJgDJaBUNZfBi
 dcg5UZ7ErPULVlamJbkqV0/jgN2YpngkcNVYs0vs5bRIP9hj0y4Kl7/YJZpd/0OQbYqunBXbB
 d8f1tUAd7xxRV42Bl/1aB5an3+SPIq+NqNY+qvvx1J5nCWKiMc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 24, 2022 at 9:54 AM <guoren@kernel.org> wrote:
> From: Guo Ren <guoren@linux.alibaba.com>

>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
