Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D406217EC
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 16:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiKHPSU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 10:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiKHPRl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 10:17:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6EE5C77C;
        Tue,  8 Nov 2022 07:17:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E05C2B81ACB;
        Tue,  8 Nov 2022 15:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8DFC433D6;
        Tue,  8 Nov 2022 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667920617;
        bh=Vf1UkwrrZO9XMpIgHbK5xWu1WEYBavSHUGvDg1Fc9Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckb/iBgMZlcxC/OivoM/trSo6/q8/mPioWhIq7js4EXJ34nEcGyHnBB6ZlIHWEsyR
         RdJQpmwxjbesWmbJZaTywXoVdHYPoZuEf1EcigCQxTPBS1ooCE4Wm5+MlEeyRqzleY
         AU4HiPA8Qf772OIQ5TYYcl+bezgaD5gneD+bDmf5asXz6tIwdhhYpwZrO5vM1ijekH
         n4DMHBkmp4ya7yppE+DH5DUW3bzJDv3yXvLyEtI9BF3ZAM1kzfUKCKLCKBqJyFfHHB
         zTtGyKtmEIiL0oi/lm3L1qr0dMJJDvqqmNL+/+vfUvki54NBA5rYfVTDTGxVlPMbl3
         yU9dphwvdGE3A==
Date:   Tue, 8 Nov 2022 08:16:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     xiafukun <xiafukun@huawei.com>, arnd@arndb.de,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, yusongping@huawei.com,
        zhaowenhui8@huawei.comx
Subject: Re: vmlinux.lds.h: Bug report: unable to handle page fault when
 start the virtual machine with qemu
Message-ID: <Y2py5533IW9RTUZD@dev-arch.thelio-3990X>
References: <cbbd3548-880c-d2ca-1b67-5bb93b291d5f@huawei.com>
 <CAMj1kXESRP9RvhPC5Wgg38BqyCn5ANv7+X9Ezyx5MXNNvEZ1kA@mail.gmail.com>
 <b714ad78-4689-ad0b-9316-efcc1665f6bf@huawei.com>
 <Y2ppOJ4zguDznRAc@dev-arch.thelio-3990X>
 <CAMj1kXGm=OXs=fw2UY7xgLP-m_gsfgW56xEmFRAm74z5+bd8Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGm=OXs=fw2UY7xgLP-m_gsfgW56xEmFRAm74z5+bd8Ow@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 08, 2022 at 04:14:44PM +0100, Ard Biesheuvel wrote:
> On Tue, 8 Nov 2022 at 15:35, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Tue, Nov 08, 2022 at 03:46:32PM +0800, xiafukun wrote:
> > > Thank you for your reply.
> > > We tested your changes to this patch and did fix the issue. Following the
> > > solution you provided, we recompile the kernel and successfully start the
> > > virtual machine.
> >
> > Thank you a lot for testing and sorry about the breakage in the first
> > place :(
> >
> > Ard, were you going to send a patch? Feel free to preemptively add:
> >
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >
> > if so; otherwise, I can send one later today.
> >
> 
> If you don't mind?

Not at all, since it is my issue and you did the hard work for me :)
Will send it out in a little bit, thanks again for the assist!

Cheers,
Nathan
