Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE3A68C73F
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 21:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBFUGi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 15:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBFUGh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 15:06:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B71EFED;
        Mon,  6 Feb 2023 12:06:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DE4CB810E5;
        Mon,  6 Feb 2023 20:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0507AC433EF;
        Mon,  6 Feb 2023 20:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675713994;
        bh=3Yg7D05MkzSc67p0IllIeOFYuHpgtoWHEDyGg89cEn4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TrFanAIL/NQxsb91JvfkKgGGInV2GbJv83xXwVospLmonVoYF0qugCWhOe08RPwaX
         KSz2R1yQLjbocys0qpEKTIJcvGgasxF/iufKfZWM+KLnESrINJ3xvu3fY01VN9IBBd
         A14tJwz1NoSgpuJDM1gKfn9n4bZjtVGyWg1FSCcjcagioOTF4tpLoxfVEQ3ZgZwQ/X
         1DTz425W+yIiGefj9MW9+XxaZDTOhpCSDxfOWIbHdEj1cNpx4bg45I7e94f2NXzAcH
         p/5XOjHti0H5HYdlYMgGbFgyQK/fMQnqBl9p3+VIiziorpSavNm5enxgwyrcpj7Rpb
         iz3O+/RqhOzlA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 09/10] riscv: fix livelock in uaccess
In-Reply-To: <Y9l02DvS6CYThTEG@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l02DvS6CYThTEG@ZenIV>
Date:   Mon, 06 Feb 2023 21:06:31 +0100
Message-ID: <87h6vyimns.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> riscv equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY han=
dling"
> If e.g. get_user() triggers a page fault and a fatal signal is caught, we=
 might
> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anyt=
hing
> to page tables.  In such case we must *not* return to the faulting insn -
> that would repeat the entire thing without making any progress; what we n=
eed
> instead is to treat that as failed (user) memory access.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reproduced with Mark's userland program -- thanks!

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
