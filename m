Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49547CE969
	for <lists+linux-arch@lfdr.de>; Wed, 18 Oct 2023 22:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjJRUwO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Oct 2023 16:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJRUwO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Oct 2023 16:52:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C418EFE;
        Wed, 18 Oct 2023 13:52:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCE0C433C8;
        Wed, 18 Oct 2023 20:52:10 +0000 (UTC)
Date:   Wed, 18 Oct 2023 16:52:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        amd-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 2dac75696c6da3c848daa118a729827541c89d33
Message-ID: <20231018165208.5267a9b9@gandalf.local.home>
In-Reply-To: <202310190456.pryB092r-lkp@intel.com>
References: <202310190456.pryB092r-lkp@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 19 Oct 2023 04:07:35 +0800
kernel test robot <lkp@intel.com> wrote:

> Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml:
> Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml:
> fs/tracefs/event_inode.c:782:11-21: ERROR: ei is NULL but dereferenced.

This was already reported and I'm currently testing a patch to fix it.

-- Steve
