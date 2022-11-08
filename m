Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719F06217CE
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 16:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiKHPPB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 10:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiKHPPA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 10:15:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA205F61;
        Tue,  8 Nov 2022 07:14:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 702C0B81ACB;
        Tue,  8 Nov 2022 15:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C77AC433B5;
        Tue,  8 Nov 2022 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667920497;
        bh=BSrrRG/ZhXmQkdS2FBxKzhgB1gK+Q0Mnr57rz3rV5pM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hfjHTIA43BylU1w3XSoAUSLOHMGLFkCrlCrSHSGzAW1jaOxorjtH9mB18I1KWA1GD
         61XDbboT/x7JItXwtaVvPUMpbpNLLXceHUVhJItFni9cj3EoOnSyKcFf+WpKG2ZH1V
         6XO0kdUJpsD52Njpxkf60SgjvPzJiv4ne26FuHZb1Gcp4glAZMlfik/zW7kiP79BLw
         +gi/+SZk+P/ttO8nTBHE3qDPe93qvfXImDwRaEd3VRE5Fix+4U85eZqSAhuKEYMzKf
         nB3VBW2nP1NCoS5LT8v5chU+sxe1F9jBrI/CSY3L0LP8heI98zJ+Ak3sPMkvq5cITl
         2xPMfmRCDbmwg==
Received: by mail-lj1-f179.google.com with SMTP id z24so21576854ljn.4;
        Tue, 08 Nov 2022 07:14:57 -0800 (PST)
X-Gm-Message-State: ACrzQf0dVh0qPOolKet1GUJaVhLmlW+1WUwwHToFU/YThiqhjE3fq5Ds
        EVCxahE+DhV3P64hn30SMZ/QJjM/UBswq0eEmtk=
X-Google-Smtp-Source: AMsMyM4GpRZEGR5+RE3pC+KFe2FHaDRiqa79fHSCcmT0n/fBEbjOSw3g36G10xBKgo0U7rA+cMgFQcc58WiLcUn05Pw=
X-Received: by 2002:a05:651c:c6:b0:277:96a:5c32 with SMTP id
 6-20020a05651c00c600b00277096a5c32mr6594997ljr.415.1667920495222; Tue, 08 Nov
 2022 07:14:55 -0800 (PST)
MIME-Version: 1.0
References: <cbbd3548-880c-d2ca-1b67-5bb93b291d5f@huawei.com>
 <CAMj1kXESRP9RvhPC5Wgg38BqyCn5ANv7+X9Ezyx5MXNNvEZ1kA@mail.gmail.com>
 <b714ad78-4689-ad0b-9316-efcc1665f6bf@huawei.com> <Y2ppOJ4zguDznRAc@dev-arch.thelio-3990X>
In-Reply-To: <Y2ppOJ4zguDznRAc@dev-arch.thelio-3990X>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 8 Nov 2022 16:14:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGm=OXs=fw2UY7xgLP-m_gsfgW56xEmFRAm74z5+bd8Ow@mail.gmail.com>
Message-ID: <CAMj1kXGm=OXs=fw2UY7xgLP-m_gsfgW56xEmFRAm74z5+bd8Ow@mail.gmail.com>
Subject: Re: vmlinux.lds.h: Bug report: unable to handle page fault when start
 the virtual machine with qemu
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     xiafukun <xiafukun@huawei.com>, arnd@arndb.de,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, yusongping@huawei.com,
        zhaowenhui8@huawei.comx
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 8 Nov 2022 at 15:35, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Tue, Nov 08, 2022 at 03:46:32PM +0800, xiafukun wrote:
> > Thank you for your reply.
> > We tested your changes to this patch and did fix the issue. Following the
> > solution you provided, we recompile the kernel and successfully start the
> > virtual machine.
>
> Thank you a lot for testing and sorry about the breakage in the first
> place :(
>
> Ard, were you going to send a patch? Feel free to preemptively add:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> if so; otherwise, I can send one later today.
>

If you don't mind?
