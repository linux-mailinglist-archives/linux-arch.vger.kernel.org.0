Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C93B737631
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 22:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFTUlb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 16:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjFTUla (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 16:41:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8219B
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 13:41:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-668689ce13fso1769245b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687293688; x=1689885688;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5z9pNcxTbLEfuGKBKG4TC9lAt5ChqheSmY8pbRkKfL4=;
        b=kTkoFl/hOE6DUn0o/TxNy8ei8a0pwF3wJ8WdqIIbNXUDBDjEdeDGAmfD2+RKWGXJTd
         T3K28E5f3GbYQN1zmSPmZIin3KKlSUuGyR86CjJT1U2jBF/N3FKoBM9bMwkagOXfEehr
         LE1fzTMO5bKWhTaPLlsyizdUF9TGPy6aFiOY/vnQgdbBWCVEGtA3s/FI33EEAwItrMJh
         VjtW979fJDNufkx776qo5gq8zTqT3t96sPZU5T73gmbYeidCAK2U6H9M5XTJ3SV4eQVW
         XmwzVsS4j/HUUONtDF+aGJdqhuO6ywBlWfNmAig3j5c9MqBK1xx+AEcWUY6eaTj23qt/
         6u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687293688; x=1689885688;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z9pNcxTbLEfuGKBKG4TC9lAt5ChqheSmY8pbRkKfL4=;
        b=CGtjAIl7lMIBu7hCdha7OpIhBwXlTJFAtlhmSaY/kivBVRDqSkQZlqNnKyj9vFxv+Q
         2kzDHfwMVFwPkWZ2ye3Ny0D1aR+Cg2KrB8fwb4fV49NV/Wcum/kKIBvgWzxkSq3Ijn3C
         rTDWkuduZYNqkx/zKZHi7zpPB6x3uHS6KI+IvRyZIIf0dumVI3W/sVlxkKs+nAJxr1Al
         GR5MgH9SvC0wePEF4byO5cUxUQR2xs7rDLNXT3LMr/gaR/765n+x0LcQXSfZTxzpbUQo
         mUjWjq2F8YVNEWYvEut9n1dLgcL+reJQG7bdWS97FYOdhQgVBhTODliphTxszUjgFbMA
         fFvA==
X-Gm-Message-State: AC+VfDwqgZ8G1opr0oWbx5WuzV2rrZmfRJ0WkbzS+8+i5WIxrKGk2Ori
        FYktFLrWMT299rU+qx/DGDZaSw==
X-Google-Smtp-Source: ACHHUZ4aN+60FiuHJ8u8JkwcNH+wuIJ6cgDETNgmrC7TB9kOIDKZRE8DYgI1KARaEW/l8jTpFSXGNw==
X-Received: by 2002:a05:6a20:432a:b0:115:5910:c82d with SMTP id h42-20020a056a20432a00b001155910c82dmr4124776pzk.43.1687293688585;
        Tue, 20 Jun 2023 13:41:28 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79145000000b006689ecd0ff4sm1442001pfi.208.2023.06.20.13.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:41:27 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:41:27 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Jun 2023 13:40:46 PDT (-0700)
Subject:     Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <CAKwvOdn_U+yjFBn6pq5XwP1rTEKA1MWBkd0f2N8wB_nuS1_sWw@mail.gmail.com>
CC:     Conor Dooley <conor@kernel.org>, jszhang@kernel.org,
        llvm@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, maskray@google.com,
        Ard Biesheuvel <ardb@kernel.org>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ndesaulniers@google.com
Message-ID: <mhng-16f1b957-5cf5-4786-a760-e4ab1fbe83ce@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 20 Jun 2023 13:32:32 PDT (-0700), ndesaulniers@google.com wrote:
> On Tue, Jun 20, 2023 at 4:13 PM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Tue, Jun 20, 2023 at 04:05:55PM -0400, Nick Desaulniers wrote:
>> > On Mon, Jun 19, 2023 at 6:06 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> > > On Thu, 15 Jun 2023 06:54:33 PDT (-0700), Palmer Dabbelt wrote:
>> > > > On Wed, 14 Jun 2023 09:25:49 PDT (-0700), jszhang@kernel.org wrote:
>> > > >> On Wed, Jun 14, 2023 at 07:49:17AM -0700, Palmer Dabbelt wrote:
>> > > >>> On Tue, 23 May 2023 09:54:58 PDT (-0700), jszhang@kernel.org wrote:
>>
>> > > >> Commit 3b90b09af5be ("riscv: Fix orphan section warnings caused by
>> > > >> kernel/pi") touches vmlinux.lds.S, so to make the merge easy, this
>> > > >> series is based on 6.4-rc2.
>> > > >
>> > > > Thanks.
>> > >
>> > > Sorry to be so slow here, but I think this is causing LLD to hang on
>> > > allmodconfig.  I'm still getting to the bottom of it, there's a few
>> > > other things I have in flight still.
>> >
>> > Confirmed with v3 on mainline (linux-next is pretty red at the moment).
>> > https://lore.kernel.org/linux-riscv/20230517082936.37563-1-falcon@tinylab.org/
>>
>> Just FYI Nick, there's been some concurrent work here from different
>> people working on the same thing & the v3 you linked (from Zhangjin) was
>> superseded by this v2 (from Jisheng).
>
> Ah! I've been testing the deprecated patch set, sorry I just looked on
> lore for "dead code" on riscv-linux and grabbed the first thread,
> without noticing the difference in authors or new version numbers for
> distinct series. ok, nevermind my noise.  I'll follow up with the
> correct patch set, sorry!

Ya, I hadn't even noticed the v3 because I pretty much only look at 
patchwork these days.  Like we talked about in IRC, I'm going to go test 
the merge of this one and see what's up -- I've got it staged at 
<https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=for-next&id=1bd2963b21758a773206a1cb67c93e7a8ae8a195>, 
though that won't be a stable hash if it's actually broken...

>
>>
>> Cheers,
>> Conor.
>
>
>
> -- 
> Thanks,
> ~Nick Desaulniers
