Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A2E2207B5
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgGOIqy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 04:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729377AbgGOIqy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 04:46:54 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F86F20657;
        Wed, 15 Jul 2020 08:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594802814;
        bh=KpvT2TBuHvXnVJEh7xCuHaK1uQCaCSpqWb1rMDlOMjc=;
        h=Date:From:To:Cc:Subject:From;
        b=I/6gtk1zy0OkXFgtT5kfqEekyOEwwSHrF5EqoUr/UiGon5REtPO9OGaCbKruHGID5
         p444q4AvfyfkdS98EjV2ErTQY1HJ+wsQ5yprtE1bm6Aq3ZcAYg0CDUdAg7njAVT7bI
         z6bj0XMVru9ToF6cKOjoEHTUh3cz0ChEs7cfoQ+w=
Date:   Wed, 15 Jul 2020 11:46:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [ANNOUNCE] linux/arch/* Microconference Accepted into 2020 Linux
 Plumbers Conference
Message-ID: <20200715084648.GC1181712@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

This year we'll hold linux/arch/* micro-conference at Linux Plumbers [1]
to discuss, well, the code in linux/arch/*.

The purpose of this micro-conference is to bring architecture
maintainers and people working on the arch-specific code together and
see how can we consolidate and generalize this functionality.

Possible topics for the discussion could be:

* Reducing code duplication and generalizing the common code in arch/
* Moving syscall processing to C
* Memory models (FLAT, DISCONTIGOUS and SPARSE)
* Devicetree
* Future of highmem
* Identifying old machine support:
  - Still in active use
  - Only in hobbyist/retro-computing
  - Completely obsolete and broken

Please send your topic proposals to the Linux Plumber's website using the
linux/arch/* as the Track you're submitting at:

https://linuxplumbersconf.org/event/7/abstracts/

The deadline for the submissions is August, 10, 2020.

Mike and Arnd.

--
[1] https://www.linuxplumbersconf.org/blog/2020/linux-arch-microconference-accepted-into-2020-linux-plumbers-conference/

-- 
Sincerely yours,
Mike.
