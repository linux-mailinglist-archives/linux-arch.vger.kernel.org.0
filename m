Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616542F497B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 12:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbhAMLCK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 06:02:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbhAMLAw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96C0123383;
        Wed, 13 Jan 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535569;
        bh=UsiaJ5TeFRIuOKIuSBE3ueTDIjqdP8/ojUP8xNThLiU=;
        h=From:To:Cc:Subject:Date:From;
        b=JwQBO8e3swkxbw4v0qYoQuzfOutZcHgnI0MSHLSa7aQYUqKKz9xGmdslvbE+6X+pl
         iQOsreIaYUaopfrnoALMeRcoV8b2ewED6qoB6VZAohTV2XoiM/Ugq8CdhsTDpkpFSC
         sHsApbyrBjWJlSbUXBv7tLCy1UNX3cGrSSAD7j++4HLesIzeEjFZVPQJn2J5oLmjON
         LO6JcKkXMZsrXk8YpCGzlX782pac1zAqJFB7uHTlnn9sXRcGD3zlcwAV7Mf5VR7pFG
         iH9Nqr9o9EuUz7C11onQCo1Sg/vfJIRxblyM1+yeUPdfpo0R+ivUmKOYdf8WcgHtgm
         MAEc9cWWKa5YQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpFo-1W; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 00/24] Fix broken file docs cross-references
Date:   Wed, 13 Jan 2021 11:59:01 +0100
Message-Id: <cover.1610535349.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

File renames and yaml conversions broke file references for several files,
as reported by:

	./scripts/documentation-file-ref-check

Fix most of them.

Please notice that this series was generated against  linux-next
(next-20210113).  So, it is better if the fixup patch could be added
at the same tree that received the patch renaming the filename.

Regards,
Mauro

Mauro Carvalho Chehab (24):
  MAINTAINERS: update adi,ad5758.yaml reference
  MAINTAINERS: update fsl,dpaa2-console.yaml reference
  MAINTAINERS: update st,hts221.yaml reference
  MAINTAINERS: update dpot-dac.yaml reference
  MAINTAINERS: update envelope-detector.yaml reference
  MAINTAINERS: update current-sense-amplifier.yaml reference
  MAINTAINERS: update current-sense-shunt.yaml reference
  MAINTAINERS: update voltage-divider.yaml reference
  MAINTAINERS: update mtk-sd.yaml reference
  MAINTAINERS: update atmel,sama5d2-adc.yaml reference
  MAINTAINERS: update pni,rm3100.yaml reference
  MAINTAINERS: update renesas,rcar-gyroadc.yaml reference
  MAINTAINERS: update st,lsm6dsx.yaml reference
  MAINTAINERS: update st,vl53l0x.yaml reference
  MAINTAINERS: update ti,dac7612.yaml reference
  Documentation/hwmon/ina2xx.rst: update ti,ina2xx.yaml reference
  arch/Kconfig: update unaligned-memory-access.rst reference
  include/linux/iio/dac/mcp4725.h: update a microchip,mcp4725.yaml ref
  doc: update rcu_dereference.rst reference
  ASoC: audio-graph-card: update audio-graph-card.yaml reference
  dt-bindings: display: mediatek: update mediatek,dpi.yaml reference
  dt-bindings: memory: mediatek: update mediatek,smi-larb.yaml
    references
  dt-bindings:iio:adc: update adc.yaml reference
  dt-bindings: phy: update phy-cadence-sierra.yaml reference

 .../bindings/display/bridge/sii902x.txt       |  2 +-
 .../display/mediatek/mediatek,disp.txt        |  4 +--
 .../bindings/iio/adc/adi,ad7192.yaml          |  2 +-
 .../bindings/media/mediatek-jpeg-decoder.txt  |  2 +-
 .../bindings/media/mediatek-jpeg-encoder.txt  |  2 +-
 .../bindings/media/mediatek-mdp.txt           |  2 +-
 .../bindings/phy/ti,phy-j721e-wiz.yaml        |  2 +-
 Documentation/hwmon/ina2xx.rst                |  2 +-
 MAINTAINERS                                   | 30 +++++++++----------
 arch/Kconfig                                  |  2 +-
 include/linux/iio/dac/mcp4725.h               |  2 +-
 tools/memory-model/Documentation/glossary.txt |  2 +-
 12 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.29.2


