Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CBF6492B3
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLKGRb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLKGRb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:17:31 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF7C12D30
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:30 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f3so6185495pgc.2
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=I1zT46a2qB5mE3jfFp3rNkiM+NV72r9+YjUvfROrgcA=;
        b=KdaQHc3p4dFuOytgBX9ynpsKvo2jXJFk32WM58zoDXit3AA+mT/KNXeX8o1b1ZBoiE
         iRmx9Q2tw5wxZ533ODjKUFMefRPQ86bGvynNOMz1BgFZI2ho5tIAO83TPssrW4/Bi7x0
         PIireN3Hx1RpmPupDbybiqPrP/S9J6UZfVTmhElUcsxVTEyaMx/FDQj37c+M3LhNkmW/
         n94gtuFa13EIVSsREy0p9g0Q0g0mSodQ75KnHzVm6iqRiOpPrgCAHDQR7b0BQtG4i4SB
         Q5Tav9SRJimhoOogJgECX8ozocXgZdxhIQM6p0i+6rtJPMjIqMZdSSagbi2ngfsw2ijg
         5sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1zT46a2qB5mE3jfFp3rNkiM+NV72r9+YjUvfROrgcA=;
        b=kPL9nOZ2ZFFDegrX1O4LVmhGpB6J4XqUi5M6u54uFSCHuOKX2t4kaY0FiGLjzDtcCi
         J5ynj/zhTWXHHeE6RTnBecOtITg5LOV9sjug/BkNO9hf6/17XaalIest+9nxq6cb6Xfu
         nFfTlTQbiQAsPnECZpGLzvjeo0Op84FMAvI69BweP2e2EZfg+G2eya6g+NjFlsfYLCDF
         pyCZH7gtidgB0VSoIbBS57JdKDga6UPa0uMEdi8BImMcmORvFLEt8NfuDwUZcNfarD8m
         TfL/hf/nSmuKEfZjiFzIRUBtAH61UPhMtr/ZS13H2NEY0mwNKVoB56cXCiNHs56OGwDz
         Zb9w==
X-Gm-Message-State: ANoB5pku/p+qwh8D09CP8tKWkAaMXrVPNkTfvD/7gFQvLTOnjLJZQKBt
        pFyJoNUn6CPPeLRejVeAWTrgoGJAAKMksBBk
X-Google-Smtp-Source: AA0mqf7n/cK/2L6C7EHdWhXnuZjhBJHwb6nNRSpHPDMLVziObOYMiAnd02w1KWFdkj/BCMG1iRqOdQ==
X-Received: by 2002:a05:6a00:1912:b0:56b:ca7a:2de2 with SMTP id y18-20020a056a00191200b0056bca7a2de2mr14109964pfi.14.1670739449466;
        Sat, 10 Dec 2022 22:17:29 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id b3-20020aa79503000000b00576f9773c80sm3510917pfp.206.2022.12.10.22.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:28 -0800 (PST)
Subject: [PATCH v2 00/24] Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:34 -0800
Message-Id: <20221211061358.28035-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This all came up in the context of increasing COMMAND_LINE_SIZE in the
RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
maximum length of /proc/cmdline and userspace could staticly rely on
that to be correct.

Usually I wouldn't mess around with changing this sort of thing, but
PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
increasing, but they're from before the UAPI split so I'm not quite sure
what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
asm-generic/setup.h.").

It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
part of the uapi to begin with, and userspace should be able to handle
/proc/cmdline of whatever length it turns out to be.  I don't see any
references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
search, but that's not really enough to consider it unused on my end.

The feedback on the v1 seemed to indicate that COMMAND_LINE_SIZE really
shouldn't be part of uapi, so this now touches all the ports.  I've
tried to split this all out and leave it bisectable, but I haven't
tested it all that aggressively.

Changes since v1 <https://lore.kernel.org/all/20210423025545.313965-1-palmer@dabbelt.com/>:
* Touches every arch.


