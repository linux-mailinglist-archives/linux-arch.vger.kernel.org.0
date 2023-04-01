Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697E36D3282
	for <lists+linux-arch@lfdr.de>; Sat,  1 Apr 2023 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDAQIT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Apr 2023 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDAQIS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Apr 2023 12:08:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE901C1DF
        for <linux-arch@vger.kernel.org>; Sat,  1 Apr 2023 09:08:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z19so24222613plo.2
        for <linux-arch@vger.kernel.org>; Sat, 01 Apr 2023 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680365297;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=ZUwOEoNvh875rA+TPV5BQ7mnuU/KXX20LmyR3axW4Q0MbJJTwjqlsl2P7TguCY21zd
         7OGV1gbcELHgjaW0x/mt9+4NPG11pl/nk/SDaMwGRE2dePzbA4E6vm84jkH4/eSoVllW
         SZxgalu9daSyzJ0SQ6YVzH5ZGglHcCwUlVJBDX71CLukf0xmgU7ZULVld8IqjphtsQyk
         st69Hn0Y4RgdPq2WvMu0GwuxsP8VN7d5K1im6lRXhlK+koAx435lzJ/0n2ZxwkOBI9C3
         B074Q1YRrqLOVJU6mJ6f5F+DiSELzil5GmHPtiyZN1YLPfWodMzBzVq1RwTOciaOnXbB
         a9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680365297;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=wSs5cJ1uFx3vcCssI9teqJ1ze7bgiWeoXfzZO4FI9m1F6YUXWi5C4kZcWtcMY5OjhB
         /UYcW+miPEcV4zSBckQrdhNZ/c7POmL4Tt7BAVqPMMNCKhDGc/XiKJWewmiQSDXv3v/b
         5p6nBrB2pIgKR1RW/TYYOpuHJRYS88O9UdY/mHg4T/dh+Ba74qX16hMgRGyZAdzIrofp
         olr0NGeW02xuYGk+y86SCIseIguqS1ciDalFZFjaQyaD00uWN7AsBvtc4voITK8KuR8u
         I86cxRqEj7AeuSc5EmzL9JUOdvI+o0wDmgRto9MRqAogUvH0RmodYvK7/80WWa3bmxW9
         6MsQ==
X-Gm-Message-State: AAQBX9c1NfKWmHRYacnJywMIbV/CgbS+CAiG9LduJYYJNfLMpGhcq6TJ
        zYN7qcImAt8jSuM22LczhVc/VAiwNRrbZg+bFqE=
X-Google-Smtp-Source: AKy350acEoMJ4Q5pdqpZOypoQsq8HKU584B+NHUTlHNsHAlO6vFYv+wz1/I471Rz2YvjFibLRZwDeWgB2SeqK//tf2I=
X-Received: by 2002:a17:90a:12c7:b0:240:9b4c:536e with SMTP id
 b7-20020a17090a12c700b002409b4c536emr5609559pjg.6.1680365297181; Sat, 01 Apr
 2023 09:08:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8c92:b0:474:c743:9f91 with HTTP; Sat, 1 Apr 2023
 09:08:16 -0700 (PDT)
Reply-To: fiona.hill.2023@outlook.com
From:   Fiona Hill <leea4982@gmail.com>
Date:   Sat, 1 Apr 2023 09:08:16 -0700
Message-ID: <CADa=nC1Ei9Fia=TEH90rN6UFyj+q+UzTGFNWj+EG8uNjUZqm_A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

-- 
Hello did you receive my message?
