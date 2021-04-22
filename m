Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F111E3688E8
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 00:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhDVWM4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 18:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbhDVWMz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 18:12:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B485C06138B
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 15:12:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q22so12090083lfu.8
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IeGVP/PzjX6GEC4OpuxzmsnoF97NjtiO1q5gl5FI7JM=;
        b=SAN+kJAryw/6OAvi1tysBLGSfweOHsy2ZldSSzEZCPRLWuQEtqq2WNl7iulOF8qc1D
         BRKDUme3/zsS4b7KxFFq5q/l6TDChCgM3mO0HRtlZM4JLJw53bizREK/ojQPzuu0s1yg
         xQCRzYjptXYhJj/GayuEMLBnUMqe43nhh40gtgdshUnp/dtKF8KorrkE59RbC+U0zKF1
         3LoKWqp69J4NsQ19gthobT+D6HMObQNV8sxa+IBu3/Xv5nG1npwJXOXIdqwW4EWw59oi
         K1YbwvUvaBJ4hh2oUUhIm85tfab8MgIoOLpmv6wde2YF9/ioL008RNGVv6XBiYQcTZCk
         LXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IeGVP/PzjX6GEC4OpuxzmsnoF97NjtiO1q5gl5FI7JM=;
        b=PH8afbUWT0ynUcfjvAySeTBzLvZPd2VpuvkOeWLX0PAvo6odeeP1CYrkNRpYSzDToL
         Ar6r9Kf+ZF571Kw+WeWI1ghjSw9JkdcX1FfbnoGu/iFdGrQ/VnyARfyw0JiwmvkxHVHl
         aKyW08BeCDYnoNdpVA05XswW5XkTSJCWb9CdPX+UWUXUEXUVRXEbzVc3KdPViizPbtOW
         7T5Egjj5fklPZEwSYG1LPSTQxhxJv/n0QbT1UROkTWh14lJHj1Ib6fNcC9UKrliIp5Kf
         1M331oYU6VLsRjepJm3wDGTrmx4e3X2lRm3PH7ckin9GJL16tEyQQf+QlOrYVgddcqXj
         lRMQ==
X-Gm-Message-State: AOAM533aNzRkgflGJzF1CH8qHk6N0TCtovU/sWA9dAnGnfGIg/hu5I39
        PppN2Dq7jL2y5ByddAZjVXboFXWNAMMaXv7CmtEVuA==
X-Google-Smtp-Source: ABdhPJyDkrllAUM3Z9CoS08VWD4PK+KcujTjeuckyHwwKe2amTgMFl/G7Y6MSZS1ns7a0NGYjS4Ke/AhIpMOrGHMj1c=
X-Received: by 2002:ac2:46ed:: with SMTP id q13mr345430lfo.543.1619129537835;
 Thu, 22 Apr 2021 15:12:17 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Apr 2021 15:12:05 -0700
Message-ID: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
Subject: ARCH=hexagon unsupported?
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-hexagon@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Brian Cain <bcain@codeaurora.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd,
No one can build ARCH=hexagon and
https://github.com/ClangBuiltLinux/linux/issues/759 has been open for
2 years.

Trying to build
$ ARCH=hexagon CROSS_COMPILE=hexagon-linux-gnu make LLVM=1 LLVM_IAS=1 -j71

shows numerous issues, the latest of which
commit 8320514c91bea ("hexagon: switch to ->regset_get()")
has a very obvious typo which misspells the `struct` keyword and has
been in the tree for almost 1 year.

Why is arch/hexagon/ in the tree if no one can build it?
-- 
Thanks,
~Nick Desaulniers
